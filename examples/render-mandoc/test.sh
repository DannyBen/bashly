#!/usr/bin/env bash

rm -f ./src/*.sh

# set -x   # can't use this here, since the piped command appears in random order

bashly render :mandoc docs

### Try Me ###

man docs/download.1 | col -bx
