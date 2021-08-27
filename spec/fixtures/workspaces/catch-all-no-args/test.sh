#!/usr/bin/env bash

# This fixture tests that catch all with help is displayed even when the
# configuration file does not have any args defined.
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/74

rm -f ./src/*.sh
rm -f ./download

set -x

bundle exec bashly generate

./download
./download --help
