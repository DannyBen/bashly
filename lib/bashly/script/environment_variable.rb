module Bashly
  module Script
    class EnvironmentVariable < Base
      include Introspection::Visibility

      class << self
        def option_keys
          @option_keys ||= %i[
            allowed default help name required private validate
          ]
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
