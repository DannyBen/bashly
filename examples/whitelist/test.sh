#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./login
./login -h
./login america
./login america --user admin
./login eu --user hacker
./login eu --user admin
./login us --user user --protocol icmp
./login eu production --user admin --protocol ssh