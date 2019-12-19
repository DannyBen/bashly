#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./cli
./cli -h
./cli dir
./cli file
./cli dir -h
./cli file -h
./cli dir list
./cli dir list -h
./cli file edit
./cli file edit -h
./cli file edit filename
