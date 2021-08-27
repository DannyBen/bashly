#!/usr/bin/env bash

# This fixture tests that short command codes work properly
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/16

rm -f ./src/*.sh
rm -f ./rush

set -x

bundle exec bashly generate

./rush c
./rush g
