#!/usr/bin/env bash

set -x

bashly add comp function --force
bashly generate

### Try Me ###

./cli
./cli -h
./cli completions -h
./cli completions
