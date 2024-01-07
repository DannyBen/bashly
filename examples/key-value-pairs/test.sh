#!/usr/bin/env bash

set -x

bashly generate

### Try Me ###

./cli -h
./cli user=bob email=bob@spunge.com --option page=2 --option count=20
