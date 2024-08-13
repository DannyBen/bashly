module Bashly
  module Script
    module Introspection
      module Arguments
        # Returns an array of Arguments
        def args
          return [] unless options['args']

          options['args'].map do |options|
            Argument.new options
          end
        end

        # Returns an array of all the default Args
        def default_args
          args.select(&:default)
        end

        # Returns true if one of the args is repeatable
        def repeatable_arg_exist?
          args.any?(&:repeatable)
        end

        # Returns an array of all the required Arguments
        def required_args
          args.select(&:required)
        end

        # Returns an array of args usage_string for the command's usage_string
        def usage_string_args
          args.map(&:usage_string)
        end

        # Returns an array of all the args with a whitelist
        def whitelisted_args
          args.select(&:allowed)
        end
      end
    end
  end
end