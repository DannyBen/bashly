#!/usr/bin/env bash

# Cleanup before testing
rm -f "src/connect_ftp_command.sh"
rm -f "src/connect_ssh_command.sh"
rm -f "src/download_command.sh"
rm -f "src/initialize.sh"
rm -f "src/upload_command.sh"

set -x

bashly generate

### Try Me ###

./cli
./cli -h
./cli connect ftp
./cli connect-ssh
./cli connect-ftp --help

