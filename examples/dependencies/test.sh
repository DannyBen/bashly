#!/usr/bin/env bash

set -x

bashly generate

./cli download
./cli upload
