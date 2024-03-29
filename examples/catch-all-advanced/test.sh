#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./cli
./cli download -h
./cli download source
./cli download source target
./cli download source target --force

# when passing arbitrary arguments that start with a hyphen...
./cli download source target --force -abc --option=value

# ...use the double dash (--) operator to disable input normalization
./cli download source target --force -- -abc --option=value

./cli upload -h
./cli upload
./cli upload file1 "file 2" file3