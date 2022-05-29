module Bashly
  # This is a `Command` concern responsible for providing additional scopes.
  module CommandScopes
    # Returns an array of all full names (including aliases and aliases of
    # parents)
    def all_full_names
      if parent_command
        parent_command.all_full_names.product(aliases).map { |a| a.join ' ' }
      else
        aliases
      end
    end

    # Returns a full list of the Command names and aliases combined
    def command_aliases
      commands.map(&:aliases).flatten
    end

    # Returns only the names of the Commands
    def command_names
      commands.map &:name
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
      commands.find { |c| c.default }
    end

    # Returns an array of all the default Args
    def default_args
      args.select &:default
    end

    # Returns an array of all the default Environment Variables
    def default_environment_variables
      environment_variables.select &:default
    end

    # Returns an array of all the default Flags
    def default_flags
      flags.select &:default
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

    # Returns a data structure for displaying subcommands help
    def commands_help_data
      group_string = strings[:commands]
      result = {}

      commands.reject(&:private).each do |command|
        summary = if command.default
          strings[:default_command_summary] % { summary: command.summary } 
        else
          command.summary
        end
        
        group_string = strings[:group] % { group: command.group } if command.group

        result[group_string] ||= {}
        result[group_string][command.name] = summary

        if command.deep_help
          command.commands.reject(&:private).each do |subcommand|
            sub_summary = if subcommand.default
              strings[:default_command_summary] % { summary: subcommand.summary } 
            else
              subcommand.summary
            end
            
            result[group_string]["#{command.name} #{subcommand.name}"] = sub_summary
          end
        end
      end

      result
    end

    # Returns an array of all the args with a whitelist
    def whitelisted_args
      args.select &:allowed
    end

    # Returns an array of all the flags with a whitelist arg
    def whitelisted_flags
      flags.select &:allowed
    end
  end
end
