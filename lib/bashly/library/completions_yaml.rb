module Bashly
  module Library
    class CompletionsYAML < Completions
      def file_content
        completions.to_yaml
      end

      def post_install_message
        <<~EOF
          This file can be converted to a completions script using the !txtgrn!completely!txtrst! gem.
        EOF
      end
    end
  end
end