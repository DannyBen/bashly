require 'simplecov'
SimpleCov.start

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
reset_tmp_dir

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

# Force generated scripts to strict mode (set -euo pipefile)
ENV['BASHLY_STRICT'] = '1'

RSpec.configure do |c|
  c.include SpecMixin
  c.strip_ansi_escape = true
end
