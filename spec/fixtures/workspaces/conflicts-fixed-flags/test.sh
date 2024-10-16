#!/usr/bin/env bash

rm -f ./cli
rm -f ./src/*.sh

set -x

bundle exec bashly generate

./cli
./cli --fast --slow
