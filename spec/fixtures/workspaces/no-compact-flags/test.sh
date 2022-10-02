#!/usr/bin/env bash

# This fixture tests that setting `compact_short_flags` to `false` indeed ignores
# this `-abc` pattern.

bundle exec bashly generate

set -x

./cli -abc --delta

# Use ad-hoc setting through an environment variable
BASHLY_COMPACT_SHORT_FLAGS="no" bundle exec bashly generate

./cli -abc --delta
./cli -a -b -c