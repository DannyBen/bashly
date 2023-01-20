module Bashly
  module Commands
    class Init < Base
      summary 'Initialize a new workspace'
      help 'This command will create the source folder, and place a template configuration file in it.'

      usage 'bashly init [--minimal]'
      usage 'bashly init (-h|--help)'

      option '-m --minimal', 'Use a minimal configuration file (without commands)'

      environment 'BASHLY_SOURCE_DIR', 'The path to use for creating the configuration file [default: src]'

      def run
        if Dir.exist?(target_dir) && !Dir.empty?(target_dir)
          raise InitError, "Directory g`#{target_dir}` already exists and is not empty"
        end

        FileUtils.mkdir_p target_dir
        File.write "#{target_dir}/bashly.yml", yaml_content
        say "g`created` #{target_dir}/bashly.yml"
        say 'run m`bashly generate` to create the bash script'
      end

    private

      def yaml_content
        @yaml_content ||= yaml_content!
      end

      def yaml_content!
        if args['--minimal']
          File.read asset('templates/minimal.yml')
        else
          File.read asset('templates/bashly.yml')
        end
      end

      def target_dir
        @target_dir ||= Settings.source_dir
      end
    end
  end
end
