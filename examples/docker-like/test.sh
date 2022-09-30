#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./docker
./docker -h
./docker container
./docker container run -h
./docker container run
./docker -d container run alpine
./docker con
./docker image
./docker image ls
./docker i l
./docker --debug ps --all
