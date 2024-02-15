#!/usr/bin/env bash

rm -f ./src/*.sh
rm -f ./cli

set -x

bundle exec bashly add validations --force
bundle exec bashly generate

./cli
./cli no-such-file
./cli README.md --template no-such-file
./cli README.md --template cli
