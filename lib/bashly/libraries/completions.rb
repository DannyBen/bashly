module Bashly
  module Libraries
    class Completions < Base
    protected
      def command
        @command ||= Script::Command.new config
      end

      def config
        @config ||= Config.new "#{Settings.source_dir}/bashly.yml"
      end
    end
  end
end