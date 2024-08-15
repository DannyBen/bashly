module Bashly
  module Script
    module Introspection
      module Visibility
        # Returns :public, :private, or :semi_private based on the `private`
        # option of the host, in conjunction with `Settings.private_reveal_key`.
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
