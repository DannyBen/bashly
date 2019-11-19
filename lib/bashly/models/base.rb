module Bashly
  module Models
    class Base
      include Renderable

      attr_reader :options

      OPTION_KEYS = %i[
        arg
        description
        flags
        help
        long
        name
        parent_name
        required
        short
        version
      ]

      def initialize(options)
        raise Error, "Invalid options provided" unless options.respond_to? :keys
        @options = options
        verify if respond_to? :verify
      end

      def method_missing(method_name, *arguments, &block)
        key = method_name.to_s
        respond_to?(method_name) ? options[key] : super
      end

      def respond_to?(method_name, include_private = false)
        # options.has_key?(method_name.to_s) || super
        OPTION_KEYS.include?(method_name) || super
      end
    end
  end
end