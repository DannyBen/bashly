module Bashly
  module Library
    class Base
      include AssetHelper

      attr_reader :target_path, :options

      def initialize(target_path = nil, options = nil)
        @target_path = target_path || Settings.source_dir
        @options = options || {}
      end

      def files
        case content
        when String then content_from_string content
        when Hash then [content]
        else content
        end
      end

      def post_install_message
        nil
      end

      def content
        raise NotImplementedError, "Please implement either #content"
      end

    private

      def content_from_string(string)
        if File.directory? asset("templates/lib/#{string}")
          content_for_dir string
        else
          [content_for_file(string)]
        end
      end

      def content_for_file(file)
        {
          path: "#{target_path}/lib/#{file}",
          content: asset_content("templates/lib/#{file}")
        }
      end

      def content_for_dir(dir)
        Dir[asset("templates/lib/#{dir}/*.sh")].sort.map do |file|
          {
            path: "#{target_path}/lib/#{dir}/#{File.basename file}",
            content: File.read(file)
          }
        end
      end

    end
  end
end