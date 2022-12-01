#!/usr/bin/env bash

set -x

bashly add config --force
bashly generate

### Try Me ###

./configly -h
./configly set hello world
./configly set bashly works
./configly get hello
./configly get invalid_key
./configly list
