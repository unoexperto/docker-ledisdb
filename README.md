# Ledisdb Dockerfile

A docker image for https://github.com/siddontang/ledisdb with RocksDB. RocksDB is compiled with all compression libraries.

Example config:
https://github.com/siddontang/ledisdb/blob/master/etc/ledis.conf

## Usage

Server:
```
docker run -d --name ledisdb --restart=on-failure:3 \
  -p 6380:6380 \
  -p 11181:11181 \
  -v <path_on_host_system>:/data:rw \
  -v <path_on_host_system>:/etc/ledisdb.conf \
  expert/ledisdb:6.6.4
```

Client:
```
$ docker run -it --rm --link ledisdb:ledisdb expert/ledisdb:6.6.4 ledis-cli -h ledisdb