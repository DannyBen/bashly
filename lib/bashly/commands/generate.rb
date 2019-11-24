module Bashly
  module Commands
    class Generate < Base
      help "Generate the bash script and required files"

      usage "bashly generate [--force]"
      usage "bashly generate (-h|--help)"

      option "-f --force", "Overwrite existing files"

      environment "BASHLY_SOURCE_DIR", "The path to use for creating the configuration file [default: src]"
      environment "BASHLY_TARGET_DIR", "The path to use for creating the bash script [default: .]"

      def run
        create_user_files
        create_master_script
        say "run !txtpur!#{master_script_path} --help!txtrst! to test your bash script"
      end

    private

      def create_user_files
        say "creating user files in !txtgrn!#{Settings.source_dir}"

        create_file "#{Settings.source_dir}/initialize.sh", command.render(:default_initialize_script)

        if command.commands.empty?
          create_root_command_file
        else
          create_all_command_files
        end
      end

      def create_root_command_file
        create_file "#{Settings.source_dir}/root_command.sh", command.render(:default_root_script)
      end

      def create_all_command_files
        command.deep_commands.each do |subcommand|
          next if subcommand.commands.any?
          file = "#{Settings.source_dir}/#{subcommand.filename}"
          content = subcommand.render :default_script
          create_file file, content
        end
      end

      def create_file(file, content)
        if File.exist? file and !args['--force']
          say "skipped !txtgrn!#{file}!txtrst! (exists)"
        else
          File.write file, content
          say "created !txtgrn!#{file}"
        end
      end

      def create_master_script
        master_script = command.render 'master_script'
        File.write master_script_path, master_script
        FileUtils.chmod "+x", master_script_path
        say "created !txtgrn!#{master_script_path}"
      end

      def master_script_path
        "#{Settings.target_dir}/#{command.name}"
      end

      def config
        @config ||= Config.new "#{Settings.source_dir}/bashly.yml"
      end

      def command
        @command ||= Models::Command.new config
      end

    end
  end
end
