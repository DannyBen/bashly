module Bashly
  module Script
    module Introspection
      module Commands
        # Returns true if the command or any of its descendants has `catch_all`
        def catch_all_used_anywhere?
          deep_commands(include_self: true).any? { |x| x.catch_all.enabled? }
        end

        # Returns a full list of the Command names and aliases combined
        def command_aliases
          commands.map(&:aliases).flatten
        end

        # Returns a data structure for displaying subcommands help
        def command_help_data
          result = {}

          commands.each do |command|
            result[command.group_string] ||= {}
            result[command.group_string][command.name] = {
              summary:    command.summary_string,
              visibility: command.visibility,
            }
            next unless command.expose

            command.commands.each do |subcommand|
              result[command.group_string]["#{command.name} #{subcommand.name}"] = {
                summary:    subcommand.summary_string,
                visibility: subcommand.visibility,
                help_only:  command.expose != 'always',
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
        # This includes children + grandchildren (recursive), and may include self
        def deep_commands(include_self: false)
          result = []
          result << self if include_self
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

        # Returns subcommands by group
        def grouped_commands
          result = {}

          visible_commands.each do |command|
            result[command.group_string] ||= []
            result[command.group_string] << command
            next unless command.expose

            command.visible_commands.each do |subcommand|
              result[command.group_string] << subcommand
            end
          end

          result
        end

        # Returns only commands that are not private
        def public_commands
          commands.reject(&:private)
        end

        # Returns a full list of the public Command names and aliases combined
        def public_command_aliases
          public_commands.map(&:aliases).flatten
        end

        # Returns only public commands, or both public and private commands
        # if Settings.private_reveal_key is set
        def visible_commands
          Settings.private_reveal_key ? commands : public_commands
        end

        # Returns a full list of the visible Command names and aliases combined
        def visible_command_aliases
          visible_commands.map(&:aliases).flatten
        end
      end
    end
  end
end
