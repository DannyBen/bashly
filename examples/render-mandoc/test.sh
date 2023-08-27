#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly render :mandoc docs

### Try Me ###

man docs/download.1 | col -bx
