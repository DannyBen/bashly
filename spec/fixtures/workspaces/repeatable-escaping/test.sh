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

# in a repeatable+unique situation, the furst arg is treated slightly
# differently, so test this case as well
./cli once x once
./cli -s once -s x -s once