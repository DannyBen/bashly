module Bashly
  module Script
    class Wrapper
      include Renderable

      attr_reader :command, :function_name

      def initialize(command, function_name = nil)
        @command, @function_name = command, function_name
      end

      def code(tab_indent: false)
        tab_indent ? base_code.expand_tabs : base_code
      end

    private

      def base_code
        result = if function_name
          [header, render('wrapper')]
        else
          [header, body]
        end

        result.join("\n").lint
      end

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