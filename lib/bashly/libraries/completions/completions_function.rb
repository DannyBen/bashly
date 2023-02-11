module Bashly
  module Libraries
    class CompletionsFunction < Base
      def files
        [
          {
            path:    "#{Settings.full_lib_dir}/#{function_name}.#{Settings.partials_extension}",
            content: completions_function_code(function_name),
          },
        ]
      end

      def post_install_message
        <<~MESSAGE
          In order to enable completions in your script, create a command or a flag (for example: g`#{command.name} completions` or g`#{command.name} --completions`) that calls the g`#{function_name}` function.

          Your users can then run something like this to enable completions:

            m`$ eval "$(#{command.name} completions)"`
        MESSAGE
      end

    private

      def function_name
        @function_name ||= args[0] || 'send_completions'
      end

      def completions_function_code(function_name)
        [
          "## [@bashly-upgrade completions #{function_name}]",
          command.completion_function(function_name),
        ].join "\n"
      end
    end
  end
end
