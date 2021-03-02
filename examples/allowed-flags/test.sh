#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./login
./login -h
./login -v
./login --user admin
./login --user no-such-user