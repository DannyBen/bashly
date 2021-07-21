#!/usr/bin/env bash

set -x

bashly add comp function
bashly generate

./cli
./cli -h
./cli completions -h
./cli completions
