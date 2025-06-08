module Bashly
  module Script
    module Introspection
      module EnvironmentVariables
        # Returns an array of all the Environment Variables with default values
        def default_environment_variables
          environment_variables.select(&:default)
        end

        # Returns an array of EnvironmentVariable objects
        def environment_variables
          return [] unless options['environment_variables']

          options['environment_variables'].map do |options|
            EnvironmentVariable.new options
          end
        end

        # Returns only environment variables that are not private
        def public_environment_variables
          environment_variables.reject(&:private)
        end

        # Returns an array of all the required EnvironmentVariables
        def required_environment_variables
          environment_variables.select(&:required)
        end

        # Returns an array of all the environment_variables with a validation
        def validated_environment_variables
          environment_variables.select(&:validate)
        end

        # Returns only public environment variables, or both public and private
        # environment variables if Settings.private_reveal_key is set
        def visible_environment_variables
          Settings.private_reveal_key ? environment_variables : public_environment_variables
        end

        # Returns an array of all the environment_variables with a whitelist arg
        def whitelisted_environment_variables
          environment_variables.select(&:allowed)
        end
      end
    end
  end
end
