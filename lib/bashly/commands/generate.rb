require 'filewatcher'

module Bashly
  module Commands
    class Generate < Base
      help 'Generate the bash script and required files'

      usage 'bashly generate [options]'
      usage 'bashly generate (-h|--help)'

      option '-f --force', 'Overwrite existing files'
      option '-q --quiet', 'Disable on-screen progress report'
      option '-u --upgrade', 'Upgrade all added library functions'
      option '-w --watch', 'Watch the source directory for changes and regenerate on change'
      option '-r --wrap FUNCTION', 'Wrap the entire script in a function so it can also be sourced'
      option '-e --env ENV', <<~HELP
        Force the generation environment:

        - development   default script output
        - production    remove file marker comments and development functions
      HELP

      example 'bashly generate --force'
      example 'bashly generate --wrap my_function'
      example 'bashly g -uw'

      attr_reader :watching

      def run
        Settings.env = args['--env'] if args['--env']
        @watching = args['--watch']

        generate
        watch if watching
      end

    private

      def watch
        quiet_say "g`watching` #{Settings.source_dir}\n"

        Filewatcher.new([Settings.source_dir]).watch do
          reset
          generate
        rescue Bashly::ConfigurationError => e
          say! "rib` #{e.class} `\n#{e.message}"
        ensure
          quiet_say "g`waiting`\n"
        end
      end

      def generate
        with_valid_config do
          quiet_say 'creating g`production` version' if Settings.production?
          generate_all_files
          quiet_say "run m`#{master_script_path} --help` to test your bash script" unless watching
        end
      end

      def reset
        @config = nil
        @config_validator = nil
        @command = nil
        @script = nil
      end

      def quiet_say(message)
        say message unless args['--quiet']
      end

      def generate_all_files
        create_user_files
        upgrade_libs if args['--upgrade']
        create_master_script
      end

      def upgrade_libs
        generated_files.each do |file|
          content = File.read file
          next unless content =~ /\[@bashly-upgrade (.+)\]/

          args = $1.split

          library_name = args.shift
          upgrade file, library_name, *args
        end
      end

      def generated_files
        Dir["#{Settings.source_dir}/**/*.*"]
      end

      def upgrade(existing_file, library_name, *args)
        if library_name.include? ';'
          source_name, library_name = library_name.split(';')
          source = Bashly::LibrarySource.new source_name
        else
          source = Bashly::LibrarySource.new
        end

        library = source.libraries[library_name.to_sym]

        if library
          library.args = args
          upgrade! existing_file, library
        else
          quiet_say "r`warning` not upgrading c`#{existing_file}`, " \
            "unknown library '#{library_name}'"
        end
      end

      def upgrade!(existing_file, library)
        file = library.find_file existing_file

        if file
          File.deep_write file[:path], file[:content]
          quiet_say "c`updated` #{file[:path]}"
        else
          quiet_say "r`warning` not upgrading c`#{existing_file}`, path mismatch"
        end
      end

      def create_user_files
        quiet_say "creating user files in g`#{Settings.source_dir}`"

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
        if File.exist?(file) && !args['--force']
          quiet_say "b`skipped` #{file} (exists)"
        else
          File.deep_write file, content
          quiet_say "g`created` #{file}"
        end
      end

      def create_master_script
        File.write master_script_path, script.code(tab_indent: Settings.tab_indent)
        FileUtils.chmod '+x', master_script_path
        quiet_say "g`created` #{master_script_path}"
      end

      def script
        @script ||= Script::Wrapper.new command, args['--wrap']
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
