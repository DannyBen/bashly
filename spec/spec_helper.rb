require 'simplecov'

if !ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch
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
Settings.strict = '1' # generate scripts with `set -euo pipefile`
Settings.env = :development
reset_tmp_dir

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'off'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

RSpec.configure do |c|
  c.include SpecMixin
  c.strip_ansi_escape = true
end
