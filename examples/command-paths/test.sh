#!/usr/bin/env bash

rm -rf ./src/commands

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli download something
ls -1 src/*