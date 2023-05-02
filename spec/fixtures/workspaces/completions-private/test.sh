#!/usr/bin/env bash

rm -f ./completions.yml

set -x
bundle exec bashly add completions_yaml
cat completions.yml