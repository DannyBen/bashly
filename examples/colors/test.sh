#!/usr/bin/env bash

set -x

bashly add colors --force
bashly generate

### Try Me ###

./colorly
NO_COLOR=1 ./colorly
