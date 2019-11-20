#!/usr/bin/env bash

rm -f ./src/*.sh

bashly generate

./cli
./cli -h
./cli --version
./cli download -h
./cli download
./cli download sourcefile targetfile -f
./cli upload --help
./cli upload sourcefile
./cli upload sourcefile -u username
