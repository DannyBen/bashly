#!/usr/bin/env bash

rm -f ./src/*.sh
rm -rf ./src/lib

set -x

bundle exec bashly add validations --force
bundle exec bashly generate

# integer
./validate 1
./validate A

# file_exists
./validate 1 README.md
./validate 1 no-such-file

# dir_exists
./validate 1 README.md src
./validate 1 README.md no-such-dir

# not_empty
./validate 1 README.md src non-empty
./validate 1 README.md src ''
