module Bashly
  module Commands
    class Validate < Base
      help "Scan the configuration file for errors"

      usage "bashly validate"
      usage "bashly validate (-h|--help)"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def run
        validate_config
        say "!txtgrn!OK"
      end
    end
  end
end
