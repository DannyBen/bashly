#!/usr/bin/env bash

bundle exec bashly generate

set -x

# good
./cli --user=admin -p=secret -- --region=us-east-1 -static

# Use ad-hoc setting through an environment variable
BASHLY_CONJOINED_FLAG_ARGS="no" bundle exec bashly generate

# good - since conjoined flags is disabled
./cli --user admin -p secret --region=us-east-1

# good - since using --
./cli --user admin -p secret -- --region=us-east-1 -static

# bad - since using --flag=value
./cli --user=admin -p=secret -- --region=us-east-1 -static
