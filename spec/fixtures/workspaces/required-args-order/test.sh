#!/usr/bin/env bash

# This fixture tests that short command codes work properly
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/16

rm -f ./src/*.sh
rm -f ./download

set -x

bundle exec bashly generate

./download
./download http
./download http 3000
./download http 3000 --method GET
./download http 3000 --method GET --role admin
./download http --role admin --method GET  3000
./download --role admin --method GET http 3000

