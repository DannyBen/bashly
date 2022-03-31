#!/usr/bin/env bash

bashly generate

### Try Me ###

./cli -h
./cli file1 file2 --format csv
./cli -f=csv file1 file2
cat file1 | ./cli --format csv
cat file* | ./cli -
