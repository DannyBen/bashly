module Bashly
  module Commands
    class Validate < Base
      help "Scan the configuration file for errors"

      usage "bashly validate"
      usage "bashly validate (-h|--help)"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def run
        config = Config.new "#{Settings.source_dir}/bashly.yml"
        validator = ConfigValidator.new config
        validator.validate
        say "!txtgrn!OK"
      end
    end
  end
end
