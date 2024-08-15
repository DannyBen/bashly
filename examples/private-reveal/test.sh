#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

# bashly generate

### Try Me ###

./cli
./cli -h
./cli admin -h

export SHOW_PLEASE=1

./cli -h
./cli admin -h
