#!/bin/bash

function build() {
    rm -rf bin;

    cat <<EOF | docker build --pull -t "build-wrk2" -
FROM gliderlabs/alpine:edge

RUN \
  apk add --update \
    curl \
    tar \
    gcc \
    make \
    musl-dev \
    perl \
    libc-dev \
    linux-headers \
    autoconf \
    automake \
    libtool \
    perl \
    zlib-dev

RUN \
  mkdir -p /wrk2 && \
  curl -sL https://github.com/giltene/wrk2/archive/master.tar.gz | \
  tar xz -C /wrk2 --strip-components 1

RUN \
  apk del ca-certificates curl openssl openssl-dev && \
  apk add libressl-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN \
  cd /wrk2 && make && mv /wrk2/wrk /wrk2/wrk2

EOF

    ID=`docker inspect -f '{{ .Id }}' build-wrk2`

    mkdir -p bin

    docker save $ID | \
        tar -xOf - "$ID/layer.tar" | \
        tar -xf - -C bin --strip-components=1 "wrk2/wrk2"

}

build
