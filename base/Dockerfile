FROM alpine:latest
MAINTAINER Michael Richardson <mcr@sandelman.ca>
RUN apk --cache-max-age 300 update
RUN apk --cache-max-age 300 add --no-cache \
        bash perl \
        clang \
        curl \
        gcc git \
        gnupg \
        libc-dev \
        linux-headers \
        make \
        procps \
        sed \
        shadow \
        tar \
        zlib-dev

RUN mkdir -p /app/fountain
WORKDIR /app/fountain
RUN mkdir -p /src/minerva
RUN mkdir -p /app/minerva
RUN cd /src/minerva && git clone -b dtls-listen-refactor-1.1.1c git://github.com/mcr/openssl.git
RUN cd /src/minerva/openssl && ./Configure --prefix=/usr --libdir=/lib --openssldir=/usr/lib/ssl no-idea no-mdc2 no-rc5 no-zlib no-ssl3 no-async linux-`uname -m` && id && make
RUN cd /src/minerva/openssl && make install_sw

