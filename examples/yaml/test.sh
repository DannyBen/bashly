#!/usr/bin/env bash

set -x

bashly generate

./yaml -h
./yaml settings.yml
./yaml settings.yml --prefix config_
./yaml settings.yml server_port
