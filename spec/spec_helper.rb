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

RSpec.configure do |c|
  c.include SpecMixin
  c.fixtures_path = "spec/approvals"
end
