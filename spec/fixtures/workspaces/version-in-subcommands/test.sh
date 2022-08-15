#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bundle exec bashly generate

./cli --version
./cli --help
./cli git --version
./cli git any "other args" -or --flags
