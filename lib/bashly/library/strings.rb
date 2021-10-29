module Bashly
  module Library
    class Strings < Base
      def content
        {
          path: "#{target_path}/bashly-strings.yml",
          content: asset_content("templates/strings.yml")
        }
      end
    end
  end
end