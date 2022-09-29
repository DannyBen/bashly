#!/usr/bin/env bash

# This fixture tests that default values for environment variables exist in
# the initialize function, and that required environment variables are NOT
# blocking --help.
# Reference issue: https://github.com/DannyBen/bashly/issues/265

rm -f ./src/download_command.sh
rm -f ./cli

bundle exec bashly generate

set -x

./cli
export CONFIG_PATH=somepath
./cli download source
export API_KEY=override-value
./cli
