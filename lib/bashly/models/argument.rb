module Bashly
  module Models
    class Argument < Base
      def optional
        !required
      end

      def usage_string
        required ? name.upcase : "[#{name.upcase}]"
      end

      def summary
        return "" unless help
        help.split("\n").first
      end
    end
  end
end