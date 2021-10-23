#!/usr/bin/env bash

rm -f ./src/*.sh
rm -rf ./src/lib

set -x

bashly add validations
bashly generate

### Try Me ###

./validate -h
./validate calc 1 2 --multiply 3
./validate calc A
./validate calc 1 B
./validate calc 1 2 --multiply C
./validate cat .gitignore
./validate cat no-such-file


