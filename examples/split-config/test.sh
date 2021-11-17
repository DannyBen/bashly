#!/usr/bin/env bash

rm -f "src/download_command.sh"
rm -f "src/initialize.sh"

set -x

bashly generate

### Try Me ###

./cli
./cli download -h
./cli upload -h
