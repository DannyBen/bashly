module Bashly
  module Script
    module Introspection
      module Visibility
        # Returns the true if the command is private and can be revealed using
        # an environemnt variable name
        def visibility
          if !options['private']
            :public
          elsif Settings.private_reveal_key
            :semi_private
          else
            :private
          end
        end
      end
    end
  end
end
