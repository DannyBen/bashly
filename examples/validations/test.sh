#!/usr/bin/env bash

rm -f ./src/*.sh
rm -rf ./src/lib

set -x

bashly add validations --force
bashly generate

### Try Me ###

./validate calc 1 2 --save README.md
./validate calc A
./validate calc 1 B
./validate calc 1 2 --save no-such-file.txt
