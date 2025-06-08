module Bashly
  module Script
    module Introspection
      module Variables
        # Returns an array of Variable objects
        def variables
          return [] unless options['variables']

          options['variables'].map do |options|
            Variable.new options
          end
        end
      end
    end
  end
end
