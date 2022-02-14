module Bashly
  module Libraries
    class Completions < Base
    using ComposeRefinements

    protected
      def command
        @command ||= Script::Command.new config
      end

      def config
        @config ||= Bashly::Config.new("#{Settings.source_dir}/bashly.yml").compose
      end
    end
  end
end