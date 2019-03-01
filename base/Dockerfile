FROM alpine:latest
MAINTAINER Michael Richardson <mcr@sandelman.ca>
RUN cat /etc/apk/repositories | while read f; do n=$(echo $f|sed -e 's,http://,,'); echo http://cacher.sandelman.ca:3142/$n; done >/etc/apk/repo-cached
RUN cat /etc/apk/repo-cached
RUN apk --repositories-file /etc/apk/repo-cached --cache-max-age 300 update; sleep 1; apk --repositories-file --cache-max-age 300 /etc/apk/repo-cached update
RUN apk --repositories-file /etc/apk/repo-cached --cache-max-age 300 add --no-cache \
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
RUN cd /src/minerva && git clone -b dtls-listen-refactor git://github.com/mcr/openssl.git
RUN cd /src/minerva/openssl && ./Configure --prefix=/usr --openssldir=/usr/lib/ssl --libdir=lib/linux-x86_64 no-idea no-mdc2 no-rc5 no-zlib no-ssl3 enable-unit-test linux-x86_64 && id && make

