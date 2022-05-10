#!/usr/bin/env bash

# This fixture tests that alias command codes work properly
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/16

rm -f ./src/*.sh
rm -f ./flags

set -x

bundle exec bashly generate

./flags -abC
./flags -d=2
./flags --echo=2
./flags -E="- hello world"
./flags -abCd

