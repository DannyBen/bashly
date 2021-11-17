module Bashly
  module Script
    class Argument < Base
      def usage_string
        required ? name.upcase : "[#{name.upcase}]"
      end
    end
  end
end