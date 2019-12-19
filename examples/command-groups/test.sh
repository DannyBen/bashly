#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./ftp
./ftp -h
./ftp login