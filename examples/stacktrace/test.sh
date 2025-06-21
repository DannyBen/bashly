#!/usr/bin/env bash

set -x

bashly add stacktrace --force
bashly generate

### Try Me ###

./download
./download --help
./download something
