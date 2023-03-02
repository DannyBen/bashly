module Bashly
  module Script
    class Dependency
      attr_reader :label, :commands, :help

      class << self
        def option_keys
          @option_keys ||= %i[command help]
        end

        def from_config(key, value)
          options = case value
          when nil
            { label: key, commands: key }
          when String
            { label: key, commands: key, help: value }
          when Hash
            { label: key, commands: value['command'], help: value['help'] }
          else
            {}
          end

          new(**options)
        end
      end

      def initialize(label: nil, commands: nil, help: nil)
        @label = label
        @commands = commands.is_a?(String) ? [commands] : commands
        @help = help&.empty? ? nil : help
      end

      def name
        @name ||= if commands.size == 1
          commands.first
        else
          "#{label} (#{commands.join '/'})"
        end
      end
    end
  end
end
