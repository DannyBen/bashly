module Bashly
  module AssetHelper
    def asset(path)
      File.expand_path "../#{path}", __dir__
    end
  end
end