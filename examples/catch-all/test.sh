#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./download
./download -h
./download something
./download something with --additional args
./download something --debug -- also pass --debug to catch_all
