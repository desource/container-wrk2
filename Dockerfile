FROM gliderlabs/alpine:edge

RUN \
  apk add libgcc --update-cache && \
  apk add libressl --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && \
  rm -rf /var/lib/apt/lists/*

ADD bin/wrk2 /bin/wrk2
ENTRYPOINT ["/bin/wrk2"]
