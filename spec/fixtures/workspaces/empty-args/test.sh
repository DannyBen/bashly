#!/usr/bin/env bash

# This fixture ensures that empty args and flag args are supported
# Reference issue: https://github.com/DannyBen/bashly/pull/135

bundle exec bashly generate

set -x

./cli test a b --flag c
./cli test ''
./cli test '' --flag ''
./cli test '' '' --flag ''
