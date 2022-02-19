module Bashly
  module Script
    class Command < Base
      include Completions
      include CommandScopes

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

      def catch_all
        @catch_all ||= CatchAll.from_config options['catch_all']
      end

      # Returns an array of the Commands
      def commands
        return [] unless options["commands"]
        options["commands"].map do |options|
          options['parents'] = parents + [name]
          Command.new options
        end
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
        options["filename"] || "#{action_name.to_underscore}_command.sh"
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
          File.read(path).remove_front_matter
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
        result << catch_all.usage_string if catch_all.enabled?
        result.join " "
      end

      # Returns an array of files to include as is inside the script
      # This is meant to provide the user with the ability to add custom
      # functions
      def user_lib
        @user_lib ||= Dir["#{Settings.full_lib_dir}/**/*.sh"].sort
      end

      # Raise an exception if there are some serious issues with the command
      # definition. This is called by Base#initialize.
      def validate_options
        Bashly::ConfigValidator.new(options).validate
      end

    end
  end
end
