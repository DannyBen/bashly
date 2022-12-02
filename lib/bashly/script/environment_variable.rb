module Bashly
  module Script
    class EnvironmentVariable < Base
      class << self
        def option_keys
          @option_keys ||= %i[default help name required private]
        end
      end

      def usage_string(extended: false)
        result = [name.upcase]
        result << strings[:required] if required && extended
        result.join ' '
      end
    end
  end
end
