module Bashly
  module Commands
    class Add < Base
      help "Add extra features and customization to your script"

      usage "bashly add strings [--force]"
      usage "bashly add lib [--force]"
      usage "bashly add config [--force]"
      usage "bashly add colors [--force]"
      usage "bashly add yaml [--force]"
      usage "bashly add validations [--force]"
      usage "bashly add comp FORMAT [OUTPUT --force]"
      usage "bashly add (-h|--help)"

      option "-f --force", "Overwrite existing files"

      param "FORMAT", "Output format, can be one of:\n  function : generate a function file to be included in your script.\n  script   : generate a standalone bash completions script.\n  yaml     : generate a yaml compatible with completely."
      param "OUTPUT", "For the 'comp function' command: Name of the generated function.\nFor the 'comp script' or 'comp yaml' commands: path to output file.\nIn all cases, this is optional and will have sensible defaults."

      command "strings", "Copy an additional configuration file to your project, allowing you to customize all the tips and error strings."
      command "lib", "Create the additional lib directory for additional user scripts. All *.sh scripts in this folder will be included in the final bash script."
      command "config", "Add standard functions for handling INI files to the lib directory."
      command "colors", "Add standard functions for printing colorful and formatted text to the lib directory."
      command "yaml", "Add standard functions for reading YAML files to the lib directory."
      command "validations", "Add argument validation functions to the lib directory."
      command "comp", "Generate a bash completions script or function."

      example "bashly add strings --force"
      example "bashly add comp function"
      example "bashly add comp script completions.bash"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def strings_command
        add_lib Library::Strings.new
      end

      def lib_command
        add_lib Library::Sample.new
      end

      def config_command
        add_lib Library::Config.new
      end

      def colors_command
        add_lib Library::Colors.new
      end

      def yaml_command
        add_lib Library::YAML.new
      end

      def validations_command
        add_lib Library::Validations.new
      end

      def comp_command
        format = args['FORMAT']
        output = args['OUTPUT']

        case format
        when "script"
          path = output || "#{Settings.target_dir}/completions.bash"
          add_lib Library::CompletionsScript.new(path)
        
        when "function"
          function = output || "send_completions"
          path = "#{Settings.source_dir}/lib/#{function}.sh"
          add_lib Library::CompletionsFunction.new(path, function: function)

        when "yaml"
          path = output || "#{Settings.target_dir}/completions.yml"
          add_lib Library::CompletionsYAML.new(path)
        
        else
          raise Error, "Unrecognized format: #{format}"

        end

      end

    private

      def add_lib(handler)
        files_created = 0
        handler.files.each do |file|
          created = safe_write file[:path], file[:content]
          files_created += 1 if created
        end
        message = handler.post_install_message
        say "\n#{message}" if message and files_created > 0
      end

      def safe_write(path, content)
        if !Dir.exist? Settings.source_dir
          raise InitError, "Directory !txtgrn!#{Settings.source_dir}!txtrst! does not exist\nRun !txtpur!bashly init!txtrst! first"
        end

        if File.exist? path and !args['--force']
          say "skipped !txtgrn!#{path}!txtrst! (exists)"
          false
        
        else
          File.deep_write path, content
          say "created !txtgrn!#{path}"
          true
        
        end
      end

    end
  end
end
