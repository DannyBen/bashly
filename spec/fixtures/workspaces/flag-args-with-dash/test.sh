#!/usr/bin/env bash

rm -f ./src/*.sh
rm -f ./argflag

set -x

bundle exec bashly generate

./argflag -f -o
./argflag -o -f
./argflag -o '--verbose --anything' -f

# if flag args are expected to look like a short flag collection, it is
# necessary to disable `compact_short_flags` either in settings or environment
# variable.
BASHLY_COMPACT_SHORT_FLAGS=no bundle exec bashly generate
./argflag -o -force
./argflag -o '-f -o'
