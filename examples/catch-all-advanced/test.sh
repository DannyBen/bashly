#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./cli
./cli download -h
./cli download source
./cli download source target
./cli download source target and --additional stuff