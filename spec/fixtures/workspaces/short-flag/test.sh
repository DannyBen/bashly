#!/usr/bin/env bash

# This fixture tests that short flags work properly
# Reference issue: https://github.com/DannyBen/bashly/issues/16

set -x

rm -f ./src/*.sh
rm -f ./rush

bashly generate

./rush c
./rush g
