require 'open3'

module Bashly
  module Script
    class Formatter
      MODES = %i[internal none shfmt]

      attr_reader :script, :mode

      def initialize(script, mode: nil)
        @script = script
        @mode = MODES.include?(mode&.to_sym) ? mode.to_sym : MODES.first
      end

      def formatted_script
        case mode
        when :internal then script.gsub(/\s+\n/m, "\n\n")
        when :shfmt then shfmt_result
        else script
        end
      end

    private

      def shfmt_result
        unless system 'command -v shfmt > /dev/null 2>&1'
          raise DependencyError,
            'Cannot find g`shfmt`.\nEither install it or change to the g`internal` formatter.'
        end

        output, error, status =
          Open3.capture3 %w[shfmt --case-indent --indent 2], stdin_data: script

        raise DependencyError, "Failed running g`shfmt`:\n\n#{error}" unless status.success?

        output
      end
    end
  end
end
