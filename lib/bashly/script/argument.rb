module Bashly
  module Script
    class Argument < Base
      def usage_string
        required ? name.upcase : "[#{name.upcase}]"
      end

      def verify
        raise ConfigurationError, "Argument must have a name" unless name
      end
    end
  end
end