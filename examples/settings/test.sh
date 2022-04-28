#!/usr/bin/env bash

rm -f ./source/*.sh

set -x

bashly generate

### Try Me ###

./out/cli
