if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

require 'bashly/extensions/array'
require 'bashly/extensions/file'
require 'bashly/extensions/string'
require 'bashly/extensions/yaml'
require 'bashly/exceptions'

module Bashly
  autoload :CLI, 'bashly/cli'
  autoload :Config, 'bashly/config'
  autoload :ConfigValidator, 'bashly/config_validator'
  autoload :Library, 'bashly/library'
  autoload :LibrarySource, 'bashly/library_source'
  autoload :MessageStrings, 'bashly/message_strings'
  autoload :RenderContext, 'bashly/render_context'
  autoload :RenderSource, 'bashly/render_source'
  autoload :VERSION, 'bashly/version'

  autoload :AssetHelper, 'bashly/concerns/asset_helper'
  autoload :Completions, 'bashly/concerns/completions'
  autoload :ComposeRefinements, 'bashly/refinements/compose_refinements'
  autoload :Renderable, 'bashly/concerns/renderable'
  autoload :Settings, 'bashly/settings'
  autoload :ValidationHelpers, 'bashly/concerns/validation_helpers'

  module Script
    autoload :Argument, 'bashly/script/argument'
    autoload :Base, 'bashly/script/base'
    autoload :CatchAll, 'bashly/script/catch_all'
    autoload :Command, 'bashly/script/command'
    autoload :Dependency, 'bashly/script/dependency'
    autoload :EnvironmentVariable, 'bashly/script/environment_variable'
    autoload :Flag, 'bashly/script/flag'
    autoload :Wrapper, 'bashly/script/wrapper'
  end

  module Commands
    autoload :Add, 'bashly/commands/add'
    autoload :Base, 'bashly/commands/base'
    autoload :Completions, 'bashly/commands/completions'
    autoload :Doc, 'bashly/commands/doc'
    autoload :Generate, 'bashly/commands/generate'
    autoload :Init, 'bashly/commands/init'
    autoload :Preview, 'bashly/commands/preview'
    autoload :Render, 'bashly/commands/render'
    autoload :Shell, 'bashly/commands/shell'
    autoload :Validate, 'bashly/commands/validate'
  end

  module Libraries
    autoload :Base, 'bashly/libraries/base'
    autoload :CompletionsFunction, 'bashly/libraries/completions/completions_function'
    autoload :CompletionsScript, 'bashly/libraries/completions/completions_script'
    autoload :CompletionsYAML, 'bashly/libraries/completions/completions_yaml'
    autoload :Help, 'bashly/libraries/help/help'
  end
end
