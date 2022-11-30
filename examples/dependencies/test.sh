#!/usr/bin/env bash

rm -f src/lib/colors.sh
rm -f src/*.sh

set -x

bashly add colors
bashly generate

### Try Me ###

./cli download
./cli upload
