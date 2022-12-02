#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

### Try Me ###

./tester -h
./tester
./tester all
./tester all -h
./tester only one
