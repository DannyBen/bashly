module Bashly
  module Script
    class Flag < Base
      def aliases
        if long and short
          [long, short]
        elsif long
          [long]
        else
          [short]
        end
      end

      def name
        long || short
      end

      def usage_string(extended: false)
        result = [aliases.join(", ")]
        result << arg.upcase if arg
        result << strings[:required] if required and extended
        result.join " "
      end

      def verify
        raise ConfigurationError, "Flag must have a long and/or short property" unless short or long
      end

    end
  end
end