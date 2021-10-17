module Bashly
  module Models
    class Argument < Base
      def usage_string
        required ? name.upcase : "[#{name.upcase}]"
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