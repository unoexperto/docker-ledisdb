FROM expert/rocksdb:6.6.4
MAINTAINER unoexperto <unoexperto.support@mailnull.com>

EXPOSE 6380 11181

#RUN mv /usr/lib/lua5.3/*.* /usr/lib/ && \
#    mv /usr/include/lua5.3/*.* /usr/include/ && \
#    rm -R /usr/include/lua5.3 && \
#    rm -R /usr/lib/lua5.3 && \
#    rm -R /usr/lua5.3

# --update-cache --repository http://nl.alpinelinux.org/alpine/edge/testing
# Compile and build LedisDB
RUN apk add lua5.1 lua5.1-dev git openssh leveldb-dev && \
    mkdir /build && \
    cd /build && \
    git clone https://github.com/siddontang/ledisdb.git /build/src/github.com/siddontang/ledisdb && \
    cd /build/src/github.com/siddontang/ledisdb && \
    source dev.sh && \
    GOGC=off go build -i -o /usr/local/bin/ledis-server -tags "snappy leveldb rocksdb" cmd/ledis-server/* && \
    GOGC=off go build -i -o /usr/local/bin/ledis-cli -tags "snappy leveldb rocksdb" cmd/ledis-cli/* && \
    GOGC=off go build -i -o /usr/local/bin/ledis-benchmark -tags "snappy leveldb rocksdb" cmd/ledis-benchmark/* && \
    GOGC=off go build -i -o /usr/local/bin/ledis-dump -tags "snappy leveldb rocksdb" cmd/ledis-dump/* && \
    GOGC=off go build -i -o /usr/local/bin/ledis-load -tags "snappy leveldb rocksdb" cmd/ledis-load/* && \
    GOGC=off go build -i -o /usr/local/bin/ledis-repair -tags "snappy leveldb rocksdb" cmd/ledis-repair/* && \
    cd / && \
    rm -rf /build && \
    mkdir /data && \
    apk del build-base linux-headers git cmake bash git

WORKDIR /data

CMD /usr/local/bin/ledis-server -config=/etc/ledisdb.conf
