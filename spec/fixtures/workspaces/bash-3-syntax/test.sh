#!/usr/bin/env bash

# This fixture tests Bash 4+-only syntax
# It is executed as part of the Runfile examples test

bundle exec bashly generate

./cli
