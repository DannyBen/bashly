#!/usr/bin/env bash

bundle exec bashly generate

set -x

echo "=== bad - since conjoined_flag_args is disabled"
./cli --user=admin

echo "=== bad - since compact_short_flags is disabled (-fd will be considered as catch_all)"
./cli --user admin --password secret -fd

echo "=== good"
./cli --user admin -p secret -f -d --region=us-east-1 -static

echo "=== good"
./cli --user admin -p secret -- --region=us-east-1 -static
