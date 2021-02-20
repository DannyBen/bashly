#!/usr/bin/env bash

# This fixture tests that short command codes work properly
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/16

rm -f ./src/*.sh
rm -f ./argflag

set -x

bashly generate

./argflag -f -o
./argflag -o -f
./argflag -o '--verbose --anything' -f
