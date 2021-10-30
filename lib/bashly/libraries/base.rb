module Bashly
  module Libraries
    class Base
      attr_reader :args

      def initialize(*args)
        @args = args
      end

      def files
        raise NotImplementedError, "Please implement #files"
      end

      def post_install_message
        nil
      end
    end
  end
end
