module Bashly
  module Script
    class Command < Base
      include Completions::Command
      include Introspection::Arguments
      include Introspection::Commands
      include Introspection::Dependencies
      include Introspection::EnvironmentVariables
      include Introspection::Examples
      include Introspection::Flags
      include Introspection::Variables
      include Introspection::Visibility

      class << self
        def option_keys
          @option_keys ||= %i[
            alias args catch_all commands completions
            default dependencies environment_variables examples
            extensible expose filename filters flags
            footer function group help header_override name
            private variables version
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

      # Returns a string suitable to be a headline
      def caption_string
        help.empty? ? full_name : "#{full_name} - #{summary}"
      end

      # Returns an object representing the catch_all configuration
      def catch_all
        @catch_all ||= CatchAll.from_config options['catch_all']
      end

      # Returns the filename that is expected to hold the user code for this
      # command
      def filename
        options['filename'] || implicit_filename
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

      # Returns the string for the group caption
      def group_string
        if group
          strings[:group] % { group: group }
        else
          strings[:commands]
        end
      end

      # Returns true if this command, or any subcommand (deep) as any arg or
      # flag with arg that is defined as unique
      def has_unique_args_or_flags?
        deep_commands(include_self: true).each do |command|
          return true if command.args.count(&:unique).positive? ||
            command.flags.count(&:unique).positive?
        end
        false
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

      # Returns true if this is the root command (no parents)
      def root_command?
        parents.empty?
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
        result = [base_usage_pattern]
        command_string = default_command&.default == 'force' ? '[COMMAND]' : 'COMMAND'

        result.push case mode
        when :global_flags    then ['[OPTIONS]', command_string]
        when :commands        then [command_string]
        when :args_and_flags  then usage_string_args + ['[OPTIONS]']
        when :args            then usage_string_args
        when :flags           then ['[OPTIONS]']
        end

        result.push catch_all.usage_string if catch_all.enabled? && commands.empty?
        result.compact.join ' '
      end

      # Returns a base usage string that considers whether this command is the
      # default, and if it has any parents. Used internally by `usage_string`.
      def base_usage_pattern
        usage_pattern = default ? "[#{name}]" : name
        parents.any? ? (parents + [usage_pattern]).join(' ') : usage_pattern
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
