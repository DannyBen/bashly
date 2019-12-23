#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./cli
./cli --help
./cli --version
./cli -h
./cli -v
./cli -h localhost -v
