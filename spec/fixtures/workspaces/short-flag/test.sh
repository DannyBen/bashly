#!/usr/bin/env bash

# This fixture tests that short flags work properly
# Reference issue: https://github.com/DannyBen/bashly/issues/16

rm -f ./src/*.sh
rm -f ./rush

set -x

bashly generate

./rush c
./rush g
