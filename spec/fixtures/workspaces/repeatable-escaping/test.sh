#!/usr/bin/env bash

rm -f ./cli

set -x

bundle exec bashly generate

./cli
./cli before "x x" "x x" after
./cli before 'x "x x"' 'x "x x"' after
./cli before 'x"x' 'x"x' after
./cli -s before -s "x x" -s "x x" -s after
./cli -s before -s 'x "x x"' -s 'x "x x"' -s after
./cli -s before -s 'x"x' -s 'x"x' -s after
