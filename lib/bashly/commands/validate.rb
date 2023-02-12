require 'lp'

module Bashly
  module Commands
    class Validate < Base
      help 'Scan the configuration file for errors'

      usage 'bashly validate [--verbose]'
      usage 'bashly validate (-h|--help)'

      option '-v --verbose', 'Show the bashly configuration file prior to validating. ' \
        'This is useful when using split config (import) since it will show the final compiled configuration.'

      def run
        if args['--verbose']
          lp config
          puts '---'
        end
        validate_config
        say 'g`OK`'
      end
    end
  end
end
