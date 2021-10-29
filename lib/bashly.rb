require 'requires'

if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

requires 'bashly/concerns'

requires 'bashly/settings'
requires 'bashly/exceptions'
requires 'bashly/script/base'
requires 'bashly/commands/base'
requires 'bashly/library/base'
requires 'bashly'
