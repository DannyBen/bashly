require 'requires'

if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

requires 'bashly/polyfills'
requires 'bashly/concerns'

requires 'bashly/settings'
requires 'bashly/exceptions'
requires 'bashly/models/base'
requires 'bashly/commands/base'
requires 'bashly'
