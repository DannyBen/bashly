#!/usr/bin/env bash

# This fixture tests the global flags feature, and specifically, that it works
# with multiple flags.
# Reference issue: https://github.com/bashly-framework/bashly/issues/293

rm -f ./src/*.sh
rm -f ./flags

set -x

bundle exec bashly generate

./flags -h
./flags show
./flags -c clark show
./flags -c chaplin show
./flags -c chaplin -ab show
