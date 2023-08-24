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
requires 'bashly/commands'
requires 'bashly/libraries/base'
requires 'bashly/libraries'
requires 'bashly/script'

require 'bashly/cli'
require 'bashly/config'
require 'bashly/config_validator'
require 'bashly/library'
require 'bashly/library_source'
require 'bashly/message_strings'
require 'bashly/settings'
require 'bashly/version'
