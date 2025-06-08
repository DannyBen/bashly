module Bashly
  module Script
    module Introspection
      module Flags
        # Returns an array of all the default Flags
        def default_flags
          flags.select(&:default)
        end

        # Returns an array of Flags
        def flags
          return [] unless options['flags']

          options['flags'].map do |options|
            Flag.new options
          end
        end

        # Returns true if this command's flags should be considered as gloal
        # flags, and cascade to subcommands
        def global_flags?
          flags.any? and commands.any?
        end

        # Returns an array of all fpags that need other flags
        def needy_flags
          flags.select(&:needs)
        end

        # Returns only flags that are not private
        def public_flags
          flags.reject(&:private)
        end

        # Returns an array of all the required Flags
        def required_flags
          flags.select(&:required)
        end

        # Returns true if one of the flags matches the provided short code
        def short_flag_exist?(flag)
          flags.any? { |f| f.short == flag }
        end

        # Returns only public flags, or both public and private flags if
        # Settings.private_reveal_key is set
        def visible_flags
          Settings.private_reveal_key ? flags : public_flags
        end

        # Returns an array of all the flags with a whitelist arg
        def whitelisted_flags
          flags.select(&:allowed)
        end
      end
    end
  end
end
