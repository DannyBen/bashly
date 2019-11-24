#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./git
./git -h
./git s
./git status -h
./git commit -h
./git commit -a -m "initial commit"