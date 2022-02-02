#!/usr/bin/env bash

rm -f ./src/*.sh
rm -rf ./src/dir_commands
rm -rf ./src/file_commands

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli dir list