#!/usr/bin/env bash

rm -f cli
rm -f src/*.sh

BASHLY_SETTINGS_PATH=my-settings.yml bundle exec bashly generate

set -x

./cli -h