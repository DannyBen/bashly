module Bashly
  module Library
    class CompletionsFunction < Completions
      def file_content
        [
          "# [@bashly-upgrade completions #{function_name}]",
          command.completion_function(function_name)
        ].join "\n"
      end

      def post_install_message
        <<~EOF
          In order to enable completions in your script, create a command or a flag (for example: !txtgrn!#{command.name} completions!txtrst! or !txtgrn!#{command.name} --completions!txtrst!) that calls the !txtgrn!#{function_name}!txtrst! function.

          Your users can then run something like this to enable completions:

            !txtpur!$ eval \"$(#{command.name} completions)\"
        EOF
      end

      def function_name
        options[:function]
      end
    end
  end
end