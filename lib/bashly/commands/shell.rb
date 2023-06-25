module Bashly
  module Commands
    class Shell < Base
      summary 'Start an interactive bashly shell'
      help 'Start an interactive shell where you can run bashly commands'

      usage 'bashly shell'
      usage 'bashly shell (-h|--help)'

      def run
        ENV['BASHLY_SHELL'] = '1'
        terminal.start
      end

    private

      def terminal
        @terminal ||= begin
          terminal = MisterBin::Terminal.new runner, {
            autocomplete: autocomplete,
            show_usage:   true,
            prompt:       "\n$> bashly ",
          }

          terminal.on('help') { runner.run %w[--help] }
          terminal.on('version') { runner.run %w[--version] }
          terminal
        end
      end

      def runner
        @runner ||= Bashly::CLI.runner
      end

      def autocomplete
        @autocomplete ||= %w[help version] + runner.commands.keys
      end
    end
  end
end
