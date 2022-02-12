module Bashly
  module Script
    class Base
      include Renderable

      attr_reader :options

      OPTION_KEYS = %i[
        allowed
        arg
        catch_all
        completions
        default
        dependencies
        description
        environment_variables
        examples
        extensible
        filters
        flags
        footer
        group
        help
        long
        name
        parent_name
        private
        required
        short
        validate
        version
      ]

      def initialize(options)
        raise Error, "Invalid options provided" unless options.respond_to? :keys
        @options = options
        validate_options if respond_to? :validate_options
      end

      def optional
        !required
      end

      def summary
        help.empty? ? "" : help.split("\n").first
      end

      def help
        options['help'] ||= ''
      end

      def method_missing(method_name, *arguments, &block)
        key = method_name.to_s
        respond_to?(method_name) ? options[key] : super
      end

      def respond_to_missing?(method_name, include_private = false)
        OPTION_KEYS.include?(method_name) || super
      end
    end
  end
end
