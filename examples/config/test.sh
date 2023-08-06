#!/usr/bin/env bash

set -x

bashly add config --force
bashly generate
rm -f config.ini

### Try Me ###

./configly -h
./configly set theme dark
./configly set user.name Operations
./configly set user.email paul@section.one
./configly set user.password s3cr3t
./configly get theme
./configly get user.name
./configly get invalid_key
./configly del user.password
./configly list
