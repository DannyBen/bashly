module Bashly
  module Models
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

      def validations
        return [] unless options['validate']
        if options['validate'].is_a? String
          [options['validate']]
        else
          options['validate']
        end
      end
    end
  end
end