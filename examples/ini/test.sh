#!/usr/bin/env bash

set -x

bashly add ini --force
bashly generate

### Try Me ###

./configly -h
./configly set hello WORLD
./configly set user.name Megatron
./configly get hello
./configly get user.name
./configly get invalid_key
./configly del user.email
./configly list
