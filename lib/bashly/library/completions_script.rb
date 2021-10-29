module Bashly
  module Library
    class CompletionsScript < Completions
      def file_content
        command.completion_script
      end

      def post_install_message
        <<~EOF
          In order to enable completions, run:

            !txtpur!$ source #{target_path}
        EOF
      end
    end
  end
end