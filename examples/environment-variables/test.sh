#!/usr/bin/env bash

set -x

bashly generate

./cli
./cli -h
./cli verify -h
./cli verify
MY_SECRET="there is no spoon" ./cli verify
ENVIRONMENT=production ./cli verify
