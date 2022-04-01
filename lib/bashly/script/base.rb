module Bashly
  module Script
    class Base
      include Renderable

      attr_reader :options

      class << self
        def option_keys
          @option_keys ||= []
        end
      end

      def initialize(options)
        raise Error, "Invalid options provided" unless options.respond_to? :keys
        @options = options
      end

      def optional
        !options['required']
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
        self.class.option_keys.include?(method_name) || super
      end
    end
  end
end
