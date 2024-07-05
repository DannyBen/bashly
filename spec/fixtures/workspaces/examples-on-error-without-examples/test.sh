#!/usr/bin/env bash

rm -f ./src/*.sh
rm -f ./cli

bundle exec bashly generate

set -x

./cli download
./cli upload
