#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly render :mandoc docs

### Try Me ###

# when running interactively, you can just run:
#
#    man docs/download.1
#
man docs/download.1 | col -bx
