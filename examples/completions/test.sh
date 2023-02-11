#!/usr/bin/env bash

set -x

bashly add completions --force
bashly generate

### Try Me ###

./cli
./cli -h
./cli completions -h
./cli completions
