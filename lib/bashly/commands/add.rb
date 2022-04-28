module Bashly
  module Commands
    class Add < Base
      help "Add extra features and customization to your script"

      usage "bashly add colors [--force]"
      usage "bashly add comp FORMAT [OUTPUT --force]"
      usage "bashly add config [--force]"
      usage "bashly add lib [--force]"
      usage "bashly add settings [--force]"
      usage "bashly add strings [--force]"
      usage "bashly add test [--force]"
      usage "bashly add validations [--force]"
      usage "bashly add yaml [--force]"
      usage "bashly add (-h|--help)"

      option "-f --force", "Overwrite existing files"

      param "FORMAT", "Output format, can be one of:\n  function : generate a function file to be included in your script.\n  script   : generate a standalone bash completions script.\n  yaml     : generate a yaml compatible with completely."
      param "OUTPUT", "For the 'comp function' command: Name of the generated function.\nFor the 'comp script' or 'comp yaml' commands: path to output file.\nIn all cases, this is optional and will have sensible defaults."

      command "colors", "Add standard functions for printing colorful and formatted text to the lib directory."
      command "comp", "Generate a bash completions script or function."
      command "config", "Add standard functions for handling INI files to the lib directory."
      command "lib", "Create the additional lib directory for additional user scripts. All *.sh scripts in this folder will be included in the final bash script."
      command "settings", "Copy a sample settings.yml file to your project, allowing you to customize some bashly options."
      command "strings", "Copy an additional configuration file to your project, allowing you to customize all the tips and error strings."
      command "test", "Add approval testing."
      command "validations", "Add argument validation functions to the lib directory."
      command "yaml", "Add standard functions for reading YAML files to the lib directory."

      example "bashly add strings --force"
      example "bashly add comp function"
      example "bashly add comp script completions.bash"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"
      environment "BASHLY_LIB_DIR", "The path to use for creating the library files, relative to the source dir [default: lib]"

      attr_reader :skip_src_check

      def colors_command
        add_lib 'colors'
      end

      def comp_command
        format = args['FORMAT']
        output = args['OUTPUT']

        case format
        when "script"   then add_lib 'completions_script', output
        when "function" then add_lib 'completions', output
        when "yaml"     then add_lib 'completions_yaml', output
        else            raise Error, "Unrecognized format: #{format}"
        end
      end

      def config_command
        add_lib 'config'
      end

      def settings_command
        @skip_src_check = true
        add_lib 'settings'
      end

      def strings_command
        add_lib 'strings'
      end

      def lib_command
        add_lib 'lib'
      end

      def test_command
        add_lib 'test'
      end

      def yaml_command
        add_lib 'yaml'
      end

      def validations_command
        add_lib 'validations'
      end

    private

      def add_lib(name, *args)
        library = Bashly::Library.new name, *args
        files_created = 0
        library.files.each do |file|
          created = safe_write file[:path], file[:content]
          files_created += 1 if created
        end
        message = library.post_install_message
        say "\n#{message}" if message and files_created > 0
      end

      def safe_write(path, content)
        if !skip_src_check and !Dir.exist? Settings.source_dir
          raise InitError, "Directory !txtgrn!#{Settings.source_dir}!txtrst! does not exist\nRun !txtpur!bashly init!txtrst! first"
        end

        if File.exist? path and !args['--force']
          say "!txtblu!skipped!txtrst! #{path} (exists)"
          false
        
        else
          File.deep_write path, content
          say "!txtgrn!created!txtrst! #{path}"
          true
        
        end
      end

    end
  end
end
