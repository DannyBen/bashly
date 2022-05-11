module Bashly
  module Commands
    class Generate < Base
      help "Generate the bash script and required files"

      usage "bashly generate [options]"
      usage "bashly generate (-h|--help)"

      option "-f --force", "Overwrite existing files"
      option "-q --quiet", "Disable on-screen progress report"
      option "-u --upgrade", "Upgrade all added library functions"
      option "-w --wrap FUNCTION", "Wrap the entire script in a function so it can also be sourced"
      option "-e --env ENV", "Force the generation environment (see BASHLY_ENV)"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"
      environment "BASHLY_TARGET_DIR", "The path to use for creating the bash script [default: .]"
      environment "BASHLY_LIB_DIR", "The path to use for upgrading library files, relative to the source dir [default: lib]"
      environment "BASHLY_STRICT", "When not empty, enable bash strict mode (set -euo pipefail)"
      environment "BASHLY_TAB_INDENT", "When not empty, the generated script will use tab indentation instead of spaces (every 2 leading spaces will be converted to a tab character)"
      environment "BASHLY_ENV", <<~EOF
        Set to 'production' or 'development':
        - production    generate a smaller script, without file markers
        - development   generate with file markers

        Can be overridden with --env [default: development]
      EOF

      example "bashly generate --force"
      example "bashly generate --wrap my_function"

      def run
        validate_config
        Settings.env = args['--env'] if args['--env']
        quiet_say "creating !txtgrn!production!txtrst! version" if Settings.production?
        create_user_files
        upgrade_libs if args['--upgrade']
        create_master_script
        quiet_say "run !txtpur!#{master_script_path} --help!txtrst! to test your bash script"
      end

    private

      def quiet_say(message)
        say message unless args['--quiet']
      end

      def upgrade_libs
        generated_files.each do |file|
          content = File.read file
          
          if content =~ /\[@bashly-upgrade (.+)\]/
            args = $1.split ' '
            library_name = args.shift
            upgrade file, library_name, *args
          end
        end
      end

      def generated_files
        Dir["#{Settings.source_dir}/**/*.*"].sort
      end

      def upgrade(existing_file, library_name, *args)
        if Library.exist? library_name
          upgrade! existing_file, library_name, *args
        else
          quiet_say "!txtred!warning!txtrst! not upgrading !txtcyn!#{existing_file}!txtrst!, unknown library '#{library_name}'"
        end
      end

      def upgrade!(existing_file, library_name, *args)
        library = Bashly::Library.new library_name, *args
        file = library.find_file existing_file

        if file
          File.deep_write file[:path], file[:content]
          quiet_say "!txtcyn!updated!txtrst! #{file[:path]}"
        else
          quiet_say "!txtred!warning!txtrst! not upgrading !txtcyn!#{existing_file}!txtrst!, path mismatch"
        end
      end

      def create_user_files
        quiet_say "creating user files in !txtgrn!#{Settings.source_dir}"

        create_file "#{Settings.source_dir}/initialize.sh", command.render(:default_initialize_script)

        if command.commands.empty?
          create_root_command_file
        else
          create_all_command_files
        end
      end

      def create_root_command_file
        create_file "#{Settings.source_dir}/#{command.filename}", command.render(:default_root_script)
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
          quiet_say "!txtblu!skipped!txtrst! #{file} (exists)"
        else
          File.deep_write file, content
          quiet_say "!txtgrn!created!txtrst! #{file}"
        end
      end

      def create_master_script
        File.write master_script_path, script.code(tab_indent: Settings.tab_indent)
        FileUtils.chmod "+x", master_script_path
        quiet_say "!txtgrn!created!txtrst! #{master_script_path}"
      end

      def script
        @script ||= Script::Wrapper.new(command, args['--wrap'])
      end

      def master_script_path
        "#{Settings.target_dir}/#{command.name}"
      end

      def command
        @command ||= Script::Command.new config
      end

    end
  end
end
