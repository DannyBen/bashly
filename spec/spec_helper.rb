require 'simplecov'

unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch
  end

  SimpleCov.at_exit do
    SimpleCov.result.format!

    result = SimpleCov.result
    if result.total_branches&.positive?
      covered_branches_percent = 100.0 * result.covered_branches / result.total_branches
      puts "Branch coverage: #{result.covered_branches} / #{result.total_branches} branches " \
        "(#{covered_branches_percent.round(2)}%) covered."
    end
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
end
