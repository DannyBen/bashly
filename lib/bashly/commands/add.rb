module Bashly
  module Commands
    class Add < Base
      help "Add extra features and customization to your script"

      usage "bashly add strings [--force]"
      usage "bashly add lib [--force]"
      usage "bashly add (-h|--help)"

      option "-f --force", "Overwrite existing files"

      command "strings", "Copy an additional configuration file to your project, allowing you to customize all the tips and error strings."
      command "lib", "Create the additional lib directory for additional user scripts. All *.sh scripts in this folder will be included in the final bash script."

      environment "BASHLY_SOURCE_DIR", "The path to use for creating the configuration file [default: src]"

      def strings_command
        safe_copy asset("templates/strings.yml"), "#{Settings.source_dir}/bashly-strings.yml"
      end

      def lib_command
        safe_copy asset("templates/sample_lib_function.sh"), "#{Settings.source_dir}/lib/sample_lib_function.sh"
      end

    private

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
    end
  end
end
