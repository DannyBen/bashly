module Bashly
  module Script
    class Command < Base
      include Completions

      # Returns the name to be used as an action.
      # - If it is the root command, the action is "root"
      # - Else, it is all the parents, except the first one (root) joined
      #   by space. For example, for a command like "docker container run"
      #   the action name is "container run".
      def action_name
        parents.any? ? (parents[1..-1] + [name]).join(' ') : "root"
      end

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

      # Returns a label for the catch_all directive
      def catch_all_label
        return nil unless catch_all

        if catch_all.is_a? String
          "#{catch_all.upcase}..."
        elsif catch_all.is_a?(Hash) and catch_all['label'].is_a?(String)
          "#{catch_all['label'].upcase}..."
        else
          "..."
        end
      end

      # Returns a used defined help string for the catch_all directive
      def catch_all_help
        return nil unless catch_all

        if catch_all.is_a?(Hash) and catch_all['help'].is_a?(String)
          catch_all['help']
        else
          nil
        end
      end

      # Returns true if catch_all is required
      def catch_all_required?
        catch_all.is_a?(Hash) and catch_all['required']
      end

      # Returns a string suitable for catch_all Usage pattern
      def catch_all_usage
        return nil unless catch_all
        catch_all_required? ? catch_all_label : "[#{catch_all_label}]"
      end

      # Returns only the names of the Commands
      def command_names
        commands.map &:name
      end

      # Returns an array of the Commands
      def commands
        return [] unless options["commands"]
        options["commands"].map do |options|
          options['parents'] = parents + [name]
          Command.new options
        end
      end

      # Returns a flat array containing all the commands in this tree.
      # This includes self + children + grandchildres + ...
      def deep_commands
        result = []
        commands.each do |command|
          result << command
          if command.commands.any?
            result += command.deep_commands
          end
        end
        result
      end

      # Returns an array of all the default Args
      def default_args
        args.select &:default
      end

      # If any of this command's subcommands has the default option set to
      # true, this default command will be returned, nil otherwise.
      def default_command
        commands.find { |c| c.default }
      end

      # Returns an array of all the default Environment Variables
      def default_environment_variables
        environment_variables.select &:default
      end

      # Returns an array of all the default Flags
      def default_flags
        flags.select &:default
      end

      # Returns an array of EnvironmentVariables
      def environment_variables
        return [] unless options["environment_variables"]
        options["environment_variables"].map do |options|
          EnvironmentVariable.new options
        end
      end

      # Returns the bash filename that is expected to hold the user code
      # for this command
      def filename
        "#{action_name.to_underscore}_command.sh"
      end

      # Returns an array of Flags
      def flags
        return [] unless options["flags"]
        options["flags"].map do |options|
          Flag.new options
        end
      end

      # Returns a unique name, suitable to be used in a bash function
      def function_name
        full_name.to_underscore
      end

      # Returns the name of the command, including its parent name (in case
      # this is a subcommand)
      def full_name
        parents.any? ? (parents + [name]).join(' ') : name
      end

      # Reads a file from the userspace (Settings.source_dir) and returns
      # its contents. 
      # If the file is not found, returns a string with a hint.
      def load_user_file(file, placeholder: true)
        path = "#{Settings.source_dir}/#{file}"
        default_content = placeholder ? "echo \"error: cannot load file\"" : ''

        content = if File.exist? path
          File.read path
        else 
          default_content
        end

        "# :#{path}\n#{content}"
      end

      # Returns an array of all parents. For example, the command 
      # "docker container run" will have [docker, container] as its parents
      def parents
        options['parents'] || []
      end

      # Returns an array of all the required Arguments
      def required_args
        args.select &:required
      end

      # Returns an array of all the required EnvironmentVariables
      def required_environment_variables
        environment_variables.select &:required
      end

      # Returns an array of all the required Flags
      def required_flags
        flags.select &:required
      end

      # Returns trus if this is the root command (no parents)
      def root_command?
        parents.empty?
      end

      # Returns true if one of the flags matches the provided short code
      def short_flag_exist?(flag)
        flags.select { |f| f.short == flag }.any?
      end

      # Returns a constructed string suitable for Usage pattern
      def usage_string
        result = [full_name]
        result << "[command]" if commands.any?
        args.each do |arg|
          result << arg.usage_string
        end
        result << "[options]" unless flags.empty?
        result << catch_all_usage if catch_all
        result.join " "
      end

      # Returns an array of files to include as is inside the script
      # This is meant to provide the user with the ability to add custom
      # functions
      def user_lib
        @user_lib ||= Dir["#{Settings.source_dir}/lib/**/*.sh"].sort
      end

      # Raise an exception if there are some serious issues with the command
      # definition.
      def verify
        verify_commands if commands.any?
      end

      # Returns an array of all the args with a whitelist
      def whitelisted_args
        args.select &:allowed
      end

      # Returns an array of all the flags with a whitelist arg
      def whitelisted_flags
        flags.select &:allowed
      end

    private

      def verify_commands
        if args.any? or flags.any?
          raise ConfigurationError, "Error in the !txtgrn!#{full_name}!txtrst! command.\nThe !txtgrn!commands!txtrst! key cannot be at the same level as the !txtgrn!args!txtrst! or !txtgrn!flags!txtrst! keys."
        end
      end

    end
  end
end
