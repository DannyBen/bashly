#!/usr/bin/env bash

rm -f ./src/*.sh
rm -f ./cli

set -x

bundle exec bashly generate

./cli
./cli -o /tmp
./cli -o /tmp -f json
