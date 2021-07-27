#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./download
./download -h
./download somesource
./download somesource -o
