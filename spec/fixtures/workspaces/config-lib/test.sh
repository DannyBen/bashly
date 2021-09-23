#!/usr/bin/env bash

# This fixture tests that the config lib scope bug
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/107

rm -f ./download

set -x

bundle exec bashly add config --force
bundle exec bashly generate

./download