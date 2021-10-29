module Bashly
  module Library
    class Completions < Base
      def content
        { path: target_path, content: file_content }
      end

      def file_content
        raise NotImplementedError, "Please implement #file_content"
      end

    protected

      def completions
        @completions ||= command.completion_data
      end

      def config
        @config ||= Bashly::Config.new "#{Settings.source_dir}/bashly.yml"
      end

      def command
        @command ||= Script::Command.new config
      end
   
    end
  end
end