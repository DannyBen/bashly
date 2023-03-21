#!/usr/bin/env bash

set -x

bashly add hooks --force
bashly generate

### Try Me ###

./hooks
./hooks --debug
