#!/usr/bin/env bash

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
./download --protocol telnet --protocol 'not"a"protocol'
