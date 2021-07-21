module Bashly
  module Commands
    class Add < Base
      help "Add extra features and customization to your script"

      usage "bashly add strings [--force]"
      usage "bashly add lib [--force]"
      usage "bashly add config [--force]"
      usage "bashly add colors [--force]"
      usage "bashly add yaml [--force]"
      usage "bashly add comp FORMAT [OUTPUT]"
      usage "bashly add (-h|--help)"

      option "-f --force", "Overwrite existing files"

      param "FORMAT", "Output format, can be one of:\n  function : generate a function file to be included in your script.\n  script   : generate a standalone bash completions script\n  yaml     : generate a yaml compatible with 'completely'"
      param "OUTPUT", "For the 'comp function' command: Name of the generated function.\nFor the 'comp script' or 'comp yaml' commands: path to output file.\nIn all cases, this is optional and will have sensible defaults."

      command "strings", "Copy an additional configuration file to your project, allowing you to customize all the tips and error strings."
      command "lib", "Create the additional lib directory for additional user scripts. All *.sh scripts in this folder will be included in the final bash script."
      command "config", "Add standard functions for handling INI files to the lib directory."
      command "colors", "Add standard functions for printing colorful and formatted text to the lib directory."
      command "yaml", "Add standard functions for reading YAML files to the lib directory."
      command "comp", "Generate a bash completions script or function."

      example "bashly add strings --force"
      example "bashly add comp function"
      example "bashly add comp script completions.bash"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def strings_command
        safe_copy asset("templates/strings.yml"), "#{Settings.source_dir}/bashly-strings.yml"
      end

      def lib_command
        safe_copy_lib "sample_function.sh"
      end

      def config_command
        safe_copy_lib "config.sh"
      end

      def colors_command
        safe_copy_lib "colors.sh"
      end

      def yaml_command
        safe_copy_lib "yaml.sh"
      end

      def comp_command
        format = args['FORMAT']
        output = args['OUTPUT']
        
        case format
        when "function"
          save_comp_function output
        when "yaml"
          save_comp_yaml output
        when "script"
          save_comp_script output
        else
          raise Error, "Unrecognized format: #{format}"
        end

      end

    private

      def safe_copy_lib(libfile)
        safe_copy asset("templates/lib/#{libfile}"), "#{Settings.source_dir}/lib/#{libfile}"
      end

      def safe_copy(source, target)
        if !Dir.exist? Settings.source_dir
          raise InitError, "Directory !txtgrn!#{Settings.source_dir}!txtrst! does not exist\nRun !txtpur!bashly init!txtrst! first"
        end

        if File.exist? target and !args['--force']
          say "skipped !txtgrn!#{target}!txtrst! (exists)"
        else
          deep_copy source, target
          say "created !txtgrn!#{target}"
        end
      end

      def deep_copy(source, target)
        target_dir = File.dirname target
        FileUtils.mkdir_p target_dir unless Dir.exist? target_dir
        FileUtils.cp source, target
      end

      def config
        @config ||= Config.new "#{Settings.source_dir}/bashly.yml"
      end

      def command
        @command ||= Models::Command.new config
      end

      def completions
        @completions ||= command.completion_data
      end

      def completions_script
        @completions_script ||= command.completion_script
      end

      def completions_function
        @completions_function ||= command.completion_function
      end

      def save_comp_yaml(filename = nil)
        filename ||= "#{Settings.target_dir}/completions.yml"
        File.write filename, completions.to_yaml
        say "created !txtgrn!#{filename}"
        say ""
        say "This file can be converted to a completions script using the !txtgrn!completely!txtrst! gem."
      end

      def save_comp_script(filename = nil)
        filename ||= "#{Settings.target_dir}/completions.bash"
        File.write filename, completions_script
        say "created !txtgrn!#{filename}"
        say ""
        say "In order to enable completions, run:"
        say ""
        say "  !txtpur!$ source #{filename}"
      end

      def save_comp_function(name = nil)
        name ||= "send_completions"
        target_dir = "#{Settings.source_dir}/lib"
        filename = "#{target_dir}/#{name}.sh"
        
        FileUtils.mkdir_p target_dir unless Dir.exist? target_dir
        File.write filename, completions_function

        say "created !txtgrn!#{filename}"
        say ""
        say "In order to use it in your script, create a command or a flag (for example: !txtgrn!#{command.name} completions!txtrst! or !txtgrn!#{command.name} --completions!txtrst!) that calls the !txtgrn!#{name}!txtrst! function."
        say "Your users can then run something like this to enable completions:"
        say ""
        say "  !txtpur!$ eval \"$(#{command.name} completions)\""
      end

    end
  end
end
