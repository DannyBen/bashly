module Bashly
  module Script
    class Argument < Base
      class << self
        def option_keys
          @option_keys ||= %i[
            allowed default help name repeatable required validate
          ]
        end
      end

      def usage_string
        required ? label : "[#{label}]"
      end

      def label
        repeatable ? "#{name.upcase}..." : name.upcase
      end
    end
  end
end