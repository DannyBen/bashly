module Bashly
  module Library
    class Completions < Base
      def content
        {
          path: target_path,
          content: file_content
        }
      end

      def post_install_message
        case format
        when 'script'
          <<~EOF
            In order to enable completions, run:

              !txtpur!$ source #{target_path}
          EOF
        
        when 'function'
          <<~EOF
            In order to enable completions in your script, create a command or a flag (for example: !txtgrn!#{command.name} completions!txtrst! or !txtgrn!#{command.name} --completions!txtrst!) that calls the !txtgrn!#{function_name}!txtrst! function.

            Your users can then run something like this to enable completions:

              !txtpur!$ eval \"$(#{command.name} completions)\"
          EOF

        else
          <<~EOF
            This file can be converted to a completions script using the !txtgrn!completely!txtrst! gem.
          EOF
        end
      end

    private

      def function_name
        options[:function]
      end

      def format
        options[:format]
      end

      def file_content
        case format
        when 'script' then command.completion_script
        when 'function' then command.completion_function(options[:function])
        else completions.to_yaml
        end
      end

      def completions
        @completions ||= command.completion_data
      end

      def config
        @config ||= Bashly::Config.new "#{Settings.source_dir}/bashly.yml"
      end

      def command
        @command ||= Script::Command.new config
      end
   
    end
  end
end