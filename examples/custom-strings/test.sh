#!/usr/bin/env bash

set -x

rm -f ./src/*.sh

bashly generate

./download
./download -h
./download somesource
./download somesource -o
