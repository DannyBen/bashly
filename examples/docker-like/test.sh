#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./docker
./docker -h
./docker container
./docker container run -h
./docker container run
./docker container run alpine
./docker con
./docker image
./docker image ls
./docker i l
