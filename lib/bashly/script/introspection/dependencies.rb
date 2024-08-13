module Bashly
  module Script
    module Introspection
      module Dependencies
        # Returns an array of Dependency objects
        def dependencies
          return [] unless options['dependencies']

          @dependencies ||= options['dependencies'].map do |key, value|
            Dependency.from_config key, value
          end
        end
      end
    end
  end
end
