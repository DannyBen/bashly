#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bundle exec bashly generate

./cli
./cli -h
./cli invalid
./cli --notify snail_mail
./cli push --notify slack