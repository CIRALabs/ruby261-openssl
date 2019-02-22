FROM msati/docker-rvm as builder

RUN apt-get update -qq && apt-get install -y apt-utils
RUN apt-get update -qq && apt-get install -y postgresql-client build-essential
RUN mkdir -p /app/fountain
WORKDIR /app/fountain
RUN mkdir -p /src/minerva
RUN mkdir -p /app/minerva
RUN cd /src/minerva && git clone -b dtls-listen-refactor git://github.com/mcr/openssl.git
RUN cd /src/minerva/openssl && ./Configure --prefix=/usr --openssldir=/usr/lib/ssl --libdir=lib/linux-x86_64 no-idea no-mdc2 no-rc5 no-zlib no-ssl3 enable-unit-test linux-x86_64 && id && make install_sw
RUN /usr/local/rvm/bin/rvm install 2.6.1
RUN /usr/local/rvm/bin/rvm cleanup all
RUN /usr/local/rvm/bin/rvm disk-usage all
