#!/usr/bin/env bash

rm -f ./cli

set -x

bundle exec bashly generate

./cli
./cli one "two and a half" three
./cli one 'the phrase "hello world"' three
./cli one 'bad"quote' three
./cli -s one -s "two and a half" -s three
./cli -s one -s 'the phrase "hello world"' -s three
./cli -s one -s 'bad"quote' -s three

