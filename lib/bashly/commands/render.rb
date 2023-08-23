require 'filewatcher'

module Bashly
  module Commands
    class Render < Base
      help 'Render the bashly data structure using cutsom templates'

      usage 'bashly render [options]'
      usage 'bashly render (-h|--help)'

      option '-r --root PATH', 'Path to templates root [default: templates]'
      option '-t --template NAME', 'Template name [default: main]'
      option '-w --watch', 'Watch bashly.yml and TEMPLATES_ROOT for changes and render on change'
      option '-s --save PATH', 'Save the render output to a file'

      example 'bashly render --root /path/to/templates --template main'
      example 'bashly render --watch'
      example 'bashly render --watch --save docs/cli.md'

      attr_reader :watching, :root, :view, :save

      def run
        @root = ENV['BASHLY_VIEWS_PATH'] = args['--root']
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
    end
  end
end
