FROM alpine as builder

RUN apk update
RUN apk add postgresql-client git make gcc bison flex libpq gmp-dev
RUN mkdir -p /app/fountain
WORKDIR /app/fountain
RUN mkdir -p /src/minerva
RUN mkdir -p /app/minerva
RUN cd /src/minerva && git clone -b dtls-listen-refactor-1.1.1c git://github.com/mcr/openssl.git
RUN apk add perl
RUN cd /src/minerva/openssl && ./Configure --prefix=/usr linux-x86_64 && id && make install_sw
RUN /usr/local/rvm/bin/rvm install 2.6.1
RUN /usr/local/rvm/bin/rvm cleanup all
RUN /usr/local/rvm/bin/rvm disk-usage all

RUN cd /app/minerva && git clone -b dtls-coap-client git://github.com/mcr/ruby-openssl.git
RUN /usr/local/rvm/bin/rvm 2.6.1 do gem install rake-compiler
#RUN cd /app/minerva/ruby-openssl && /usr/local/rvm/bin/rvm 2.6.1 do rake compile
