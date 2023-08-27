#!/usr/bin/env bash

rm -f ./src/*.sh

set -x

bashly render :markdown docs
