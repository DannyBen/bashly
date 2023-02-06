module Bashly
  module Libraries
    class Base
      attr_reader :args

      def initialize(*args)
        @args = args
      end

      def files
        raise NotImplementedError, 'Please implement #files'
      end

      def post_install_message
        nil
      end

    protected

      def command
        @command ||= Script::Command.new config
      end

      def config
        @config ||= Config.new Settings.config_path
      end
    end
  end
end
