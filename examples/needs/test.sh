#!/usr/bin/env bash

set -x

bashly generate

### Try Me ###

./cli -h
./cli --add deploy
./cli --add deploy --command 'git push'
./cli --add deploy --command 'git push' --target local
