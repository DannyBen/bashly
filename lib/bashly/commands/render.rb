require 'filewatcher'

module Bashly
  module Commands
    class Render < Base
      help 'Render the bashly data structure using cutsom templates'

      usage 'bashly render SOURCE TARGET [options]'
      usage 'bashly render (-h|--help)'

      param 'SOURCE', <<~HELP
        An ID to an internal templates source, or a path to a custom templates directory.

        Available IDs (note the leading colon):
        - :markdown - render markdown documents for each command.
      HELP
      
      param 'TARGET', 'Output directory'

      option '-w --watch', 'Watch bashly.yml and the templates source for changes and render on change'

      example 'bashly render :markdown docs --watch'
      example 'bashly render /path/to/templates ./out_path'

      attr_reader :watching, :source, :target

      def run
        @source = source_path
        @target = args['TARGET']
        @watching = args['--watch']

        render
        watch if watching
      end

    private

      # This method is the single DSL method for the render script
      def save(filename, content)
        File.deep_write filename, content
        say "g`saved` #{filename}"
      end

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
        with_valid_config { instance_eval render_script }
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
        @watchables ||= [Settings.config_path, source]
      end

      def source_path
        result = args['SOURCE']

        if result.start_with? ':'
          id = result[1..]
          result = asset "views-alt/#{id}"
        end

        return result if Dir.exist? result

        raise "Invalid source.\nDirectory not found: #{result}"
      end

      def render_script
        @render_script ||= File.read "#{source}/render.rb"
      end
    end
  end
end
