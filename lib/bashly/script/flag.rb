require 'shellwords'

module Bashly
  module Script
    class Flag < Base
      include Completions::Flag

      class << self
        def option_keys
          @option_keys ||= %i[
            allowed arg completions conflicts default help long needs
            repeatable required short unique validate private
          ]
        end
      end

      def aliases
        if long && short
          [long, short]
        elsif long
          [long]
        else
          [short]
        end
      end

      def default_string
        if default.is_a?(Array)
          Shellwords.shelljoin default
        elsif default.is_a?(String) && repeatable
          Shellwords.shellescape default
        else
          default
        end
      end

      def name
        long || short
      end

      def usage_string(extended: false)
        result = [aliases.join(', ')]
        result << arg.upcase if arg
        result << strings[:required] if required && extended
        result << strings[:repeatable] if repeatable && extended
        result.join ' '
      end
    end
  end
end
