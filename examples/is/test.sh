#!/usr/bin/env bash

set -x

bashly generate

./exist -h
./exist no/such.file
./exist README.md

