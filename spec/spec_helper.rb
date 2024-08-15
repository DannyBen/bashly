require 'simplecov'

unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch if ENV['BRANCH_COV']
    coverage_dir 'spec/coverage'
  end
end

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'bashly'
include Bashly

require_relative 'spec_mixin'
include SpecMixin

# Set up working directory for the specs
Settings.source_dir = 'spec/tmp/src'
Settings.target_dir = 'spec/tmp'
Settings.strict = true # generate scripts with `set -euo pipefail`
Settings.env = :development
reset_tmp_dir

# This is used in the Settings spec, to ensure we are working with an
# eigenclass that has a known state
BaselineSettings = Settings.clone

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

RSpec.configure do |config|
  config.include SpecMixin
  config.example_status_persistence_file_path = 'spec/status.txt'
  config.strip_ansi_escape = true
  config.filter_run_excluding :noci if ENV['CI']
end
