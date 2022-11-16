module Bashly
  module Libraries
    class CompletionsScript < Completions
      def files
        [
          {
            path:    target_path,
            content: command.completion_script,
          },
        ]
      end

      def post_install_message
        <<~MESSAGE
          In order to enable completions, run:

            !txtpur!$ source #{target_path}
        MESSAGE
      end

    private

      def target_path
        @target_path ||= args[0] || "#{Settings.target_dir}/completions.bash"
      end
    end
  end
end
