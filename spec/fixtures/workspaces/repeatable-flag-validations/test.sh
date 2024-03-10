#!/usr/bin/env bash

rm -f ./cli
rm -f ./src/initialize.sh
rm -f ./src/root_command.sh

set -x

bundle exec bashly generate

./cli
./cli --number 1
./cli --number 1.1
./cli --number a
./cli --number 1 --number 2
./cli --number 1.1 --number 2
./cli --number 1 --number 2.2
./cli --number 1 --number a
./cli --number 1 --number 'bad"quote'
