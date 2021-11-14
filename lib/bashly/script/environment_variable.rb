module Bashly
  module Script
    class EnvironmentVariable < Base
      def usage_string(extended: false)
        result = [name.upcase]
        result << strings[:required] if required and extended
        result.join " "
      end

      def verify
        raise ConfigurationError, "EnvironmentVariable must have a name" unless name
      end
    end
  end
end