module Bashly
  module Script
    class Argument < Base
      def usage_string
        required ? label : "[#{label}]"
      end

      def label
        repeatable ? "#{name.upcase}..." : name.upcase
      end
    end
  end
end