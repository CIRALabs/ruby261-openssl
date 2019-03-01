FROM msati/docker-rvm as builder

RUN apt-get update -qq && apt-get install -y apt-utils libssl-dev
RUN apt-get update -qq && apt-get install -y postgresql-client build-essential
RUN mkdir -p /app/fountain
WORKDIR /app/fountain
RUN mkdir -p /src/minerva
RUN mkdir -p /app/minerva
RUN cd /src/minerva && git clone -b dtls-listen-refactor git://github.com/mcr/openssl.git
RUN cd /src/minerva/openssl && ./Configure --prefix=/usr --openssldir=/usr/lib/ssl --libdir=lib/linux-x86_64 no-idea no-mdc2 no-rc5 no-zlib no-ssl3 enable-unit-test linux-x86_64 && id && make
RUN cd /src/minerva/openssl && make install_sw
RUN /usr/local/rvm/bin/rvm install --disable-binary 2.6.1
RUN /usr/local/rvm/bin/rvm cleanup all
RUN /usr/local/rvm/bin/rvm disk-usage all

RUN cd /app/minerva && git clone -b dtls-coap-client git://github.com/mcr/ruby-openssl.git
RUN /usr/local/rvm/bin/rvm 2.6.1 do gem install rake-compiler
RUN cd /app/minerva/ruby-openssl && /usr/local/rvm/bin/rvm 2.6.1 do rake compile
RUN /usr/local/rvm/bin/rvm 2.6.1 do gem install bundler
RUN /usr/local/rvm/bin/rvm cleanup all
RUN /usr/local/rvm/bin/rvm disk-usage all
