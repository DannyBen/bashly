require 'lp'

module Bashly
  module Commands
    class Validate < Base
      help 'Scan the configuration file for errors'

      usage 'bashly validate [--verbose]'
      usage 'bashly validate (-h|--help)'

      option '-v --verbose', 'Show the bashly configuration file prior to validating. ' \
        'This is useful when using split config (import) since it will show the final compiled configuration.'

      environment 'BASHLY_SOURCE_DIR', 'The path containing the bashly configuration and source files [default: src]'

      def run
        if args['--verbose']
          lp config
          puts '---'
        end
        validate_config
        show_deprecations
        deprecations = config_validator.deprecations
        if deprecations.empty?
          say 'g`OK`'
        else
          say "r`WARNING` Found #{deprecations.count} deprecations"
        end
      end
    end
  end
end
