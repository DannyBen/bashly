#!/usr/bin/env bash

set -x
bundle exec bashly add completions_yaml --force
cat completions.yml