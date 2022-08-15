#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli dir
./cli file
# verify invalid commands properly error
./cli dig
./cli dir -h
./cli file -h
./cli dir list
./cli dir list -h
# verify invalid subcommands properly error
./cli dir lost -h
./cli file edit
./cli file edit -h
./cli file edit filename
