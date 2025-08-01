require 'open3'
require 'shellwords'

module Bashly
  module Script
    class Formatter
      MODES = %i[internal none shfmt]

      attr_reader :script, :mode

      def initialize(script, mode: nil)
        @script = script
        @mode = mode || :internal
      end

      def formatted_script
        case mode
        when :internal then script.gsub(/\s+\n/m, "\n\n")
        when :shfmt then shfmt_result
        when :none then script
        else custom_formatter_result mode
        end
      end

    private

      def shfmt_result
        custom_formatter_result %w[shfmt --case-indent --indent 2]
      end

      def custom_formatter_result(command)
        command = Shellwords.split command if command.is_a? String

        begin
          output, error, status = Open3.capture3(*command, stdin_data: script)
        rescue Errno::ENOENT
          raise Error, "Command not found: `#{command.join(' ')}`"
        end

        raise Error, "Failed running `#{command.join(' ')}`:\n\n#{error}" unless status.success?

        output
      end
    end
  end
end
