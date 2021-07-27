#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./convert
./convert -h
./convert *.bmp
./convert -f pdf
./convert *.pdf --format gif