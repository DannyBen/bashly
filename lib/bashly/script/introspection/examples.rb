module Bashly
  module Script
    module Introspection
      module Examples
        # Returns an array of examples
        def examples
          return nil unless options['examples']

          options['examples'].is_a?(Array) ? options['examples'] : [options['examples']]
        end
      end
    end
  end
end
