require 'requires'

if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

requires 'bashly/concerns'

requires 'bashly/extensions'
requires 'bashly/settings'
requires 'bashly/exceptions'
requires 'bashly/refinements'
requires 'bashly/script/base'
requires 'bashly/commands/base'
requires 'bashly/libraries/base'
requires 'bashly'
