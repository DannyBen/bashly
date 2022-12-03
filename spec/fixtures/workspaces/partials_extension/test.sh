#!/usr/bin/env bash

# This fixture tests that changing the setting partials_extension to bash
# applies the desired extension to all generated files.

rm -rf ./src

set -x

# Make it so
export BASHLY_PARTIALS_EXTENSION=bash

# Generate the initial script
bundle exec bashly init
bundle exec bashly generate

# Add all libraries known to mankind (those that generate .sh files)
bundle exec bashly add colors
bundle exec bashly add comp function
bundle exec bashly add config
bundle exec bashly add help
bundle exec bashly add lib
bundle exec bashly add validations
bundle exec bashly add yaml

# Verify upgrading works
bundle exec bashly generate --upgrade

# Finally, verify the script actually works
./cli
./cli --help
./cli download something