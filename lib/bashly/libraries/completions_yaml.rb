module Bashly
  module Libraries
    class CompletionsYAML < Base
      def files
        [
          {
            path:    target_path,
            content: command.completion_data.to_yaml,
          },
        ]
      end

      def post_install_message
        <<~MESSAGE
          This file can be converted to a completions script using the !txtgrn!completely!txtrst! gem.
        MESSAGE
      end

    private

      def target_path
        @target_path ||= args[0] || "#{Settings.target_dir}/completions.yml"
      end
    end
  end
end
