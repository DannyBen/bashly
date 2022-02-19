#!/usr/bin/env bash

# This fixture tests that the config lib scope bug
# It is executed as part of the Runfile examples test
# Reference issue: https://github.com/DannyBen/bashly/issues/107

rm -f ./download
rm -f ./src/initialize.sh
rm -f ./src/root_command.sh

set -x

bundle exec bashly generate

./download
./download -p ssh
./download -p ssh -p ftp
./download -p sftp -p https
./download -p http -p ftp
./download --protocol telnet
