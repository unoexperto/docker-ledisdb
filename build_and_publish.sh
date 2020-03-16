#!/usr/bin/env bash

#docker login
docker build --ulimit memlock=-1 -t expert/ledisdb:6.6.4 .
#docker push expert/ledisdb:6.6.4
#docker logout
