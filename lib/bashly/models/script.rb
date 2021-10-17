module Bashly
  module Models
    class Script
      include Renderable

      attr_reader :command, :function_name

      def initialize(command, function_name = nil)
        @command, @function_name = command, function_name
      end

      def code
        if function_name
          result = [header, render('wrapper')].join "\n"
        else
          result = [header, body].join "\n"
        end

        result.lint
      end

    private

      def header
        @header ||= header!
      end

      def header!
        if File.exist? custom_header_path
          File.read custom_header_path
        else
          default_header
        end
      end

      def default_header
        result = render('header')
        result += render('bash3_bouncer') unless function_name
        result
      end

      def body
        @body ||= command.render('master_script')
      end

      def custom_header_path
        @custom_header_path ||= "#{Settings.source_dir}/header.sh"
      end
    end
  end
end