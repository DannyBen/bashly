#!/usr/bin/env bash

set -x

bashly generate

./cli
./cli -h
./cli completions -h
./cli completions