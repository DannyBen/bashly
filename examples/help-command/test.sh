#!/usr/bin/env bash

rm -f src/*.sh

set -x

bashly add help
bashly generate

### Try Me ###

./cli
./cli -h
./cli help
./cli help download
./cli help no_such_command
