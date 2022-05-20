module Bashly
  module Script
    class Flag < Base
      include Completions::Flag

      class << self
        def option_keys
          @option_keys ||= %i[
            allowed arg completions conflicts default help long repeatable
            required short validate
          ]
        end
      end
      
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
        result << strings[:repeatable] if repeatable and extended
        result.join " "
      end
    end
  end
end