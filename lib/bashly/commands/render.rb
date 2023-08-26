require 'filewatcher'
require 'tty-markdown'

module Bashly
  module Commands
    class Render < Base
      help 'Render the bashly data structure using cutsom templates'

      usage 'bashly render SOURCE TARGET [options]'
      usage 'bashly render SOURCE --about'
      usage 'bashly render --list'
      usage 'bashly render (-h|--help)'

      param 'SOURCE', <<~HELP
        An ID to an internal templates source, or a path to a custom templates directory.

        A leading colon (:) denotes an internal ID (see `--list`).
      HELP

      param 'TARGET', 'Output directory'

      option '-w --watch', 'Watch bashly.yml and the templates source for changes and render on change'
      option '-l --list', 'Show list of built-in templates'
      option '-a --about', 'Show information about a given templates source'

      example 'bashly render --list'
      example 'bashly render :markdown --about'
      example 'bashly render :markdown docs --watch'
      example 'bashly render /path/to/templates ./out_path'

      attr_reader :watching, :target, :source

      def run
        if args['--list'] then show_list
        elsif args['--about'] then show_about
        else
          start_render
        end
      end

    private

      def show_list
        RenderSource.internal.each_value do |source|
          say "g`:#{source.selector.to_s.ljust 10}`  #{source.summary}"
        end
      end

      def show_about
        puts TTY::Markdown.parse(render_source.readme)
      end

      def render_source
        @render_source ||= begin
          source = RenderSource.new selector
          raise "Invalid render source: #{args['SOURCE']}" unless source.exist?

          source
        end
      end

      def selector
        return args['SOURCE'] unless args['SOURCE'].start_with? ':'

        args['SOURCE'][1..].to_sym
      end

      def start_render
        @target = args['TARGET']
        @watching = args['--watch']

        render
        watch if watching
      end

      def render
        render_source.render target
      end

      def watch
        say "g`watching`\n"

        Filewatcher.new(watchables).watch do
          render
          say "g`waiting`\n"
        end
      end

      def watchables
        @watchables ||= [Settings.config_path, args['SOURCE']]
      end
    end
  end
end
