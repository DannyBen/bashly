module Bashly
  module Script
    class Variable < Base
      class << self
        def option_keys
          @option_keys ||= %i[name value]
        end
      end
    end
  end
end
