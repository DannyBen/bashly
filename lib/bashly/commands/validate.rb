module Bashly
  module Commands
    class Validate < Base
      help "Scan the configuration file for errors"

      usage "bashly validate"
      usage "bashly validate (-h|--help)"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def run
        validate_config
        show_deprecations
        deprecations = config_validator.deprecations
        if deprecations.empty?
          say "!txtgrn!OK"
        else
          say "!txtred!WARNING!txtrst! Found #{deprecations.count} deprecations"
        end
      end
    end
  end
end
