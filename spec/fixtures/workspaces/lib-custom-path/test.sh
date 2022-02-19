#!/usr/bin/env bash

# This fixture tests that BASHLY_LIB_DIR properly influences all commands that 
# use it.
# It is executed as part of the Runfile examples test

rm -f ./cli
rm -rf ./src/my-libz
export BASHLY_LIB_DIR=my-libz

set -x

bundle exec bashly generate
bundle exec bashly add lib
bundle exec bashly add colors
bundle exec bashly generate
./cli
bundle exec bashly generate --upgrade
bundle exec bashly add comp function
