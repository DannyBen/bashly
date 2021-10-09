#!/usr/bin/env bash

# This is a custom header that will be injected to the very top of the 
# script, replacing the original header.
# Note that in most cases you should use initialize.sh instead.

some_condition=true

if [ "$some_condition" = true ]; then
  echo "Some condition was met, aborting"
  exit
fi

