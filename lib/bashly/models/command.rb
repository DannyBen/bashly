module Bashly
  module Models
    class Command < Base
      # Returns all the possible aliases for this command
      def aliases
        short ? [name, short] : [name]
      end

      # Returns an array of Arguments
      def args
        return [] unless options["args"]
        options["args"].map do |options|
          Argument.new options
        end
      end

      # Returns a string suitable to be a headline
      def caption_string
        help ? "#{full_name} - #{summary}" : full_name
      end

      # Returns only the names of the subcommands (Commands)
      def command_names
        commands.map &:name
      end

      # Returns an array of the subcommands (Commands)
      def commands
        return [] unless options["commands"]
        options["commands"].map do |options|
          options['parent_name'] = full_name
          command = Command.new options
        end
      end

      # Returns an array of Flags
      def flags
        return [] unless options["flags"]
        options["flags"].map do |options|
          Flag.new options
        end
      end

      # Returns the name of the command, including its parent name (in case
      # this is a subcommand)
      def full_name
        parent_name ? "#{parent_name} #{name}" : name
      end

      # Returns true if this is a subcommand with a parent
      def has_parent?
        !!parent_name
      end

      # Reads a file from the userspace (Settings.source_dir) and returns
      # its contents. 
      # If the file is not found, returns a string with a hint.
      def load_user_file(file, placeholder: true)
        path = "#{Settings.source_dir}/#{file}"
        default_content = placeholder ? "# error: cannot load file" : ''

        content = if File.exist? path
          File.read path
        else 
          default_content
        end

        "# :#{path}\n#{content}"
      end

      # Returns an array of all the required Arguments
      def required_args
        args.select &:required
      end

      # Returns an array of all the required Flags
      def required_flags
        flags.select &:required
      end

      # Returns trus if this is the root command (no parents)
      def root_command?
        !has_parent?
      end

      # Returns the first line of the help message
      def summary
        return "" unless help
        help.split("\n").first
      end

      # Returns a constructed string suitable for Usage pattern
      def usage_string
        result = [full_name]
        result << "[command]" if commands.any?
        args.each do |arg|
          result << arg.usage_string
        end
        result << "[options]"
        result.join " "
      end

      # Returns an array of files to include as is inside the script
      # This is meant to provide the user with the ability to add custom
      # functions
      def user_lib
        @user_lib ||= Dir["#{Settings.source_dir}/lib/**/*.sh"]
      end

      # Raise an exception if there are some serious issues with the command
      # definition.
      def verify
        verify_commands if commands.any?
      end

    private

      def verify_commands
        if args.any? or flags.any?
          raise ConfigurationError, "Error in the !txtgrn!#{full_name}!txtrst! command.\nThe !txtgrn!commands!txtrst! key cannot be at the same level as the !txtgrn!args!txtrst! or !txtgrn!flags!txtrst! keys."
        end

        if has_parent?
          raise ConfigurationError, "Error in the !txtgrn!#{full_name}!txtrst! command.\nNested commands are not supported."
        end
      end

    end
  end
end