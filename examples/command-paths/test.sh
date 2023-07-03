#!/usr/bin/env bash

rm -rf ./src/commands

set -x

bashly generate

### Try Me ###

./docker
./docker -h
./docker container run alpine
ls -R src