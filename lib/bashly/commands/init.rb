require 'mister_bin'

module Bashly
  module Commands
    class Init < MisterBin::Command
      summary "Initialize a new workspace"
      help "This command will create the source folder, and place a template configuration file in it."

      usage "bashly init [--minimal]"
      usage "bashly init (-h|--help)"

      option "-m --minimal", "Use a minimal configuration file (without subcommands)"

      environment "BASHLY_SOURCE_DIR", "The path to use for creating the configuration file [default: src]"

      def run
        if Dir.exist? target_dir and !Dir.empty? target_dir
          raise InitError, "Directory !txtgrn!#{target_dir}!txtrst! already exists and is not empty"
        end
        Dir.mkdir target_dir unless Dir.exist? target_dir
        File.write "#{target_dir}/bashly.yml", yaml_content
        say "created !txtgrn!#{target_dir}/bashly.yml"
        say "run !txtpur!bashly generate!txtrst! to create the bash script"
      end

    private

      def yaml_content
        @yaml_content ||= yaml_content!
      end

      def yaml_content!
        if args['--minimal']
          File.read minimal_template_file
        else
          File.read template_file
        end
      end

      def template_file
        File.expand_path '../templates/bashly.yml', __dir__
      end

      def minimal_template_file
        File.expand_path '../templates/minimal.yml', __dir__
      end

      def target_dir
        @target_dir ||= Settings.source_dir
      end
    end
  end
end
