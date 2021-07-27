#!/usr/bin/env bash

rm -f ./src/*.sh

# Fool the terminal to think our cli-status file is in the path
export PATH="$PWD:$PATH"

set -x

bashly generate

### Try Me ###

./cli
./cli status --some --flags
