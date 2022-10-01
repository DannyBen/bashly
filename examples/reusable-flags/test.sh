#!/usr/bin/env bash

rm -f ./src/*.sh
set -x

bashly generate

### Try Me ###

./cli -h
./cli download -h
./cli upload -h
./cli upload --force
./cli download --debug
