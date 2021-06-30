#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly generate

./mygit
./mygit push

# any unknown command will go to the git executable
./mygit rm
