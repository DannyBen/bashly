#!/usr/bin/env bash

rm -f ./src/*.sh
rm -f ./cli

set -x

bundle exec bashly generate

./cli
./cli -fd
./cli source -fd
