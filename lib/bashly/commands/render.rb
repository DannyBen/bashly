require 'filewatcher'

module Bashly
  module Commands
    class Render < Base
      help 'Render the bashly data structure using cutsom templates'

      usage 'bashly render LOCATION [options]'
      usage 'bashly render (-h|--help)'

      param 'LOCATION', <<~HELP
        An ID to an internal templates root, or a path to a custom templates root.

        Available IDs (note the leading colon):
        - :markdown - render markdown documents for each command.
      HELP

      option '-t --template NAME', 'Template name [default: main]'
      option '-w --watch', 'Watch bashly.yml and TEMPLATES_ROOT for changes and render on change'
      option '-s --save PATH', 'Save the render output to a file'

      example 'bashly render :markdown'
      example 'bashly render /path/to/templates --template main'
      example 'bashly render --watch'
      example 'bashly render --watch --save docs/index.md'

      attr_reader :watching, :root, :view, :save

      def run
        @root = ENV['BASHLY_VIEWS_PATH'] = root_path
        @view = args['--template']
        @save = args['--save']
        ENV['BASHLY_RENDER_PATH'] = @save ? File.dirname(@save) : '.'
        @watching = args['--watch']

        render
        watch if watching
      end

    private

      def watch
        say "g`watching` #{watchables.join ', '}\n"

        Filewatcher.new(watchables).watch do
          reset
          render
        rescue Bashly::ConfigurationError => e
          say! "rib` #{e.class} `\n#{e.message}"
        ensure
          say "g`waiting`\n"
        end
      end

      def render
        with_valid_config do
          output = command.render view
          if save
            File.deep_write save, output
            say "g`saved` #{save}"
          else
            puts output
          end
        end
      end

      def reset
        @config = nil
        @config_validator = nil
        @command = nil
      end

      def command
        @command ||= Script::Command.new config
      end

      def watchables
        @watchables ||= [Settings.config_path, root]
      end

      def root_path
        result = args['LOCATION']

        if result.start_with? ':'
          id = result[1..]
          result = asset "views-alt/#{id}"
        end

        return result if Dir.exist? result

        raise "Invalid location.\nDirectory not found: #{result}"
      end
    end
  end
end
