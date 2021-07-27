#!/usr/bin/env bash

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli verify -h
./cli verify
MY_SECRET="there is no spoon" ./cli verify
ENVIRONMENT=production MY_SECRET=safe-with-me ./cli verify
