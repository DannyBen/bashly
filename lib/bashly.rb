require 'requires'

if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

requires 'bashly/settings'
requires 'bashly/exceptions'
requires 'bashly/concerns'
requires 'bashly/models/base'
requires 'bashly'
