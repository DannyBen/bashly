#!/usr/bin/env bash

set -x

bundle exec bashly generate

### Try Me ###

./cli -h
./cli deploy -h
./cli deploy --build --test
