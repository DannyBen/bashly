#!/usr/bin/env bash

set -x

bashly generate

### Try Me ###

./download -h
./download
./download -d one -d "two three" -vvv
./download -d one --path /bin --path /usr/lib --path /bin
