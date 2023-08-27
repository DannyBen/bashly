#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly render :markdown docs

### Try Me ###

cat docs/index.md
