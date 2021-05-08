#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./download
./download -h
./download something
./download something with --additional args