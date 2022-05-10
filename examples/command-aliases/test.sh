#!/usr/bin/env bash

# Cleanup before testing
rm -f src/*.sh

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli download -h
./cli d somefile
./cli upload --help
./cli u --help
./cli push somefile


