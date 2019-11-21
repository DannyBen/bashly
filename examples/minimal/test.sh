#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./download
./download -h
./download --version
./download somesource -f