#!/usr/bin/env bash

rm -f ./src/*.sh

bashly generate

./download
./download -h
./download --version
./download somesource -f