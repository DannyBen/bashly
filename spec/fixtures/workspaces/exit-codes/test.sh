#!/usr/bin/env bash

# This fixture tests proper exit codes
# It is executed as part of the Runfile examples test

rm -f ./src/*.sh
rm -f ./cli

bundle exec bashly generate

expect() {
  actual="$1"
  expected="$2"
  if [[ "$actual" == "$expected" ]]; then
    echo "  - PASS: Expected $expected, got $actual"
  else
    echo "  - FAIL: Expected $expected, got $actual"
  fi
}

echo "=== test: missing env var"
./cli
expect $? 1

export API_KEY='secret'

echo "=== test: usage"
./cli
expect $? 1

echo "=== test: --help"
./cli --help
expect $? 0

echo "=== test: missing argument"
./cli download
expect $? 1

echo "=== test: missing flag"
./cli login
expect $? 1
