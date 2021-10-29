module Bashly
  module AssetHelper
    def asset(path)
      File.expand_path "../#{path}", __dir__
    end

    def asset_content(path)
      File.read asset(path)
    end
  end
end