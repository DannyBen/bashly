#!/usr/bin/env bash

rm -f ./src/*.sh
rm -rf ./src/lib

set -x

bashly add validations
bashly generate

### Try Me ###

./calc -h
./calc add 1 2 --multiply 3
./calc add A
./calc add 1 B
./calc add 1 2 --multiply C


