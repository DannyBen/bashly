#!/usr/bin/env bash

set -x

bashly generate

./configly -h
./configly set hello world
./configly set bashly works
./configly get hello
./configly get invalid_key
./configly list
