#!/usr/bin/env bash

# Cleanup before testing
rm -f src/*.sh

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli container-start --help
./cli container start --help
