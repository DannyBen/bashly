#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./multi
./multi -h
./multi multiline
./multi multiline -h
