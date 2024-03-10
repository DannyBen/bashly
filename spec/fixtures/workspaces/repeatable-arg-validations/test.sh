#!/usr/bin/env bash

rm -f ./cli
rm -f ./src/initialize.sh
rm -f ./src/root_command.sh

set -x

bundle exec bashly generate

./cli
./cli 1
./cli 1.1
./cli a
./cli 1 2
./cli 1.1 2
./cli 1 2.2
./cli 1 a
./cli 1 'not"a"number'
