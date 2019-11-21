module Bashly
  module Commands
    class Add < Base
      help "Add extra features and customization to your script"

      usage "bashly add strings [--force]"
      usage "bashly add (-h|--help)"

      option "-f --force", "Overwrite existing files"

      command "strings", "Copy an additional configuration file to your project, allowing you to customize all the tips and error strings."

      environment "BASHLY_SOURCE_DIR", "The path to use for creating the configuration file [default: src]"

      def strings_command
        safe_copy asset("templates/strings.yml"), "#{Settings.source_dir}/bashly-strings.yml"
      end

    private

      def safe_copy(source, target)
        if !Dir.exist? Settings.source_dir
          raise InitError, "Directory !txtgrn!#{Settings.source_dir}!txtrst! does not exist\nRun !txtpur!bashly init!txtrst! first"
        end

        if File.exist? target and !args['--force']
          say "skipped !txtgrn!#{target}!txtrst! (exists)"
        else
          FileUtils.cp source, target
          say "created !txtgrn!#{target}"
        end
      end
    end
  end
end
