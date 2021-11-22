module Bashly
  # This is a `Command` concern responsible for providing additional scopes.
  module CommandScopes
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
