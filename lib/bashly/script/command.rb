module Bashly
  module Script
    class Command < Base
      include Completions::Command

      class << self
        def option_keys
          @option_keys ||= %i[
            alias args catch_all commands completions
            default dependencies environment_variables examples
            extensible expose filename filters flags
            footer function group help name
            private version
          ]
        end
      end

      attr_accessor :parent_command
      attr_writer :parents

      # Returns the name to be used as an action.
      # - If it is the root command, the action is "root"
      # - Else, it is all the parents, except the first one (root) joined
      #   by space. For example, for a command like "docker container run"
      #   the action name is "container run".
      def action_name
        parents.any? ? (parents[1..] + [name]).join(' ') : 'root'
      end

      # Returns all the possible aliases for this command
      def aliases
        [name] + alt
      end

      # Returns an array of alternative aliases if any
      def alt
        return [] unless options['alias']

        options['alias'].is_a?(String) ? [options['alias']] : options['alias']
      end

      # Returns an array of Arguments
      def args
        return [] unless options['args']

        options['args'].map do |options|
          Argument.new options
        end
      end

      # Returns a string suitable to be a headline
      def caption_string
        help.empty? ? full_name : "#{full_name} - #{summary}"
      end

      # Returns an object representing the catch_all configuration
      def catch_all
        @catch_all ||= CatchAll.from_config options['catch_all']
      end

      # Returns a full list of the Command names and aliases combined
      def command_aliases
        commands.map(&:aliases).flatten
      end

      # Returns a data structure for displaying subcommands help
      def command_help_data
        result = {}

        public_commands.each do |command|
          result[command.group_string] ||= {}
          result[command.group_string][command.name] = { summary: command.summary_string }
          next unless command.expose

          command.public_commands.each do |subcommand|
            result[command.group_string]["#{command.name} #{subcommand.name}"] = {
              summary:   subcommand.summary_string,
              help_only: command.expose != 'always',
            }
          end
        end

        result
      end

      # Returns only the names of the Commands
      def command_names
        commands.map(&:name)
      end

      # Returns an array of the Commands
      def commands
        return [] unless options['commands']

        options['commands'].map do |options|
          result = Command.new options
          result.parents = parents + [name]
          result.parent_command = self
          result
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

      # If any of this command's subcommands has the default option set to
      # true, this default command will be returned, nil otherwise.
      def default_command
        commands.find(&:default)
      end

      # Returns an array of all the default Args
      def default_args
        args.select(&:default)
      end

      # Returns an array of all the default Environment Variables
      def default_environment_variables
        environment_variables.select(&:default)
      end

      # Returns an array of all the default Flags
      def default_flags
        flags.select(&:default)
      end

      # Returns an array of Dependency objects
      def dependencies
        return [] unless options['dependencies']

        @dependencies ||= options['dependencies'].map do |key, value|
          Dependency.from_config key, value
        end
      end

      # Returns an array of EnvironmentVariable objects
      def environment_variables
        return [] unless options['environment_variables']

        options['environment_variables'].map do |options|
          EnvironmentVariable.new options
        end
      end

      # Returns an array of examples
      def examples
        return nil unless options['examples']

        options['examples'].is_a?(Array) ? options['examples'] : [options['examples']]
      end

      # Returns the filename that is expected to hold the user code for this
      # command
      def filename
        options['filename'] || implicit_filename
      end

      # Returns an array of Flags
      def flags
        return [] unless options['flags']

        options['flags'].map do |options|
          Flag.new options
        end
      end

      # Returns a unique name, suitable to be used in a bash function
      def function_name
        options['function'] || full_name.to_underscore
      end

      # Returns the name of the command, including its parent name (in case
      # this is a subcommand)
      def full_name
        parents.any? ? (parents + [name]).join(' ') : name
      end

      # Returns true if this command's flags should be considered as gloal
      # flags, and cascade to subcommands
      def global_flags?
        flags.any? and commands.any?
      end

      # Returns the string for the group caption
      def group_string
        if group
          strings[:group] % { group: group }
        else
          strings[:commands]
        end
      end

      # Returns subcommands by group
      def grouped_commands
        result = {}

        public_commands.each do |command|
          result[command.group_string] ||= []
          result[command.group_string] << command
          next unless command.expose

          command.public_commands.each do |subcommand|
            result[command.group_string] << subcommand
          end
        end

        result
      end

      # Returns a mode identifier
      def mode
        @mode ||= if global_flags?    then :global_flags
        elsif commands.any?           then :commands
        elsif args.any? && flags.any? then :args_and_flags
        elsif args.any?               then :args
        elsif flags.any?              then :flags
        else
          :empty
        end
      end

      # Returns an array of all parents. For example, the command
      # "docker container run" will have [docker, container] as its parents
      def parents
        @parents ||= []
      end

      # Returns only commands that are not private
      def public_commands
        commands.reject(&:private)
      end

      # Returns a full list of the public Command names and aliases combined
      def public_command_aliases
        public_commands.map(&:aliases).flatten
      end

      # Returns only environment variables that are not private
      def public_environment_variables
        environment_variables.reject(&:private)
      end

      # Returns only flags that are not private
      def public_flags
        flags.reject(&:private)
      end

      # Returns true if one of the args is repeatable
      def repeatable_arg_exist?
        args.any?(&:repeatable)
      end

      # Returns an array of all the required Arguments
      def required_args
        args.select(&:required)
      end

      # Returns an array of all the required EnvironmentVariables
      def required_environment_variables
        environment_variables.select(&:required)
      end

      # Returns an array of all the required Flags
      def required_flags
        flags.select(&:required)
      end

      # Returns true if this is the root command (no parents)
      def root_command?
        parents.empty?
      end

      # Returns true if one of the flags matches the provided short code
      def short_flag_exist?(flag)
        flags.any? { |f| f.short == flag }
      end

      # Returns the summary string
      def summary_string
        if default
          strings[:default_command_summary] % { summary: summary }
        else
          summary
        end
      end

      # Returns a constructed string suitable for Usage pattern
      def usage_string
        result = [full_name]

        result.push case mode
        when :global_flags    then ['[OPTIONS]', 'COMMAND']
        when :commands        then ['COMMAND']
        when :args_and_flags  then usage_string_args + ['[OPTIONS]']
        when :args            then usage_string_args
        when :flags           then ['[OPTIONS]']
        end

        result.push catch_all.usage_string if catch_all.enabled? && commands.empty?
        result.compact.join ' '
      end

      # Returns an array of args usage_string for the command's usage_string
      def usage_string_args
        args.map(&:usage_string)
      end

      # Returns an array of files to include as is inside the script
      # This is meant to provide the user with the ability to add custom
      # functions
      def user_lib
        @user_lib ||= Dir["#{Settings.full_lib_dir}/**/*.#{Settings.partials_extension}"]
      end

      # Returns a mixed array of Argument and Flag objects that have validations
      def validatables
        @validatables ||= args.select(&:validate) + flags.select(&:validate)
      end

      # Returns an array of all the args with a whitelist
      def whitelisted_args
        args.select(&:allowed)
      end

      # Returns an array of all the environemnt_variables with a whitelist arg
      def whitelisted_environment_variables
        environment_variables.select(&:allowed)
      end

      # Returns an array of all the flags with a whitelist arg
      def whitelisted_flags
        flags.select(&:allowed)
      end

    private

      # Returns either a flat filename (docker_status_command.sh) or a nested
      # path (commands/docker/status.sh)
      def implicit_filename
        if Settings.commands_dir
          "#{Settings.commands_dir}/#{action_name.to_path}.#{Settings.partials_extension}"
        else
          "#{action_name.to_underscore}_command.#{Settings.partials_extension}"
        end
      end
    end
  end
end
