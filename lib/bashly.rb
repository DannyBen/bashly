if ENV['DEBUGGER']
  require 'debug'
  require 'lp'
end

require 'requires'
requires 'bashly/extensions'
requires 'bashly/exceptions'

module Bashly
  autoloads 'bashly/refinements', %i[ComposeRefinements]

  autoloads 'bashly', %i[
    CLI Config ConfigValidator Library LibrarySource LibrarySourceConfig
    MessageStrings RenderContext RenderSource Settings VERSION
  ]

  autoloads 'bashly/concerns', %i[
    AssetHelper Completions Renderable ValidationHelpers
  ]

  module Script
    autoloads 'bashly/script', %i[
      Argument Base CatchAll Command Dependency EnvironmentVariable Flag
      Variable Wrapper
    ]

    module Introspection
      autoloads 'bashly/script/introspection', %i[
        Arguments Commands Dependencies EnvironmentVariables Examples Flags
        Variables Visibility
      ]
    end
  end

  module Commands
    autoloads 'bashly/commands', %i[
      Add Base Completions Doc Generate Init Preview Render Shell Validate
    ]
  end

  module Libraries
    autoload :Base, 'bashly/libraries/base'
    autoload :CompletionsFunction, 'bashly/libraries/completions/completions_function'
    autoload :CompletionsScript, 'bashly/libraries/completions/completions_script'
    autoload :CompletionsYAML, 'bashly/libraries/completions/completions_yaml'
    autoload :Help, 'bashly/libraries/help/help'
  end
end
