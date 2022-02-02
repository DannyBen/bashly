#!/usr/bin/env bash

rm -f "src/initialize.sh"

bashly generate

### Try Me ###

./cli some-file
cat some-file | ./cli
cat some-file | ./cli -
