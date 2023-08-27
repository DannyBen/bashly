module Bashly
  class RenderSource
    attr_reader :selector

    class << self
      include AssetHelper

      def internal
        @internal ||= internal_dirs.to_h do |dir|
          selector = File.basename(dir).to_sym
          [selector, new(selector)]
        end
      end

      def internal_dirs
        @internal_dirs ||= Dir["#{internal_root}/*"].select { |x| File.directory? x }
      end

      def internal_root
        asset('libraries/render')
      end
    end

    def initialize(selector)
      @selector = selector
    end

    def render(target, show: nil)
      context = RenderContext.new source: path, target: target, show: show
      context.instance_eval render_script
    end

    def internal?
      selector.is_a? Symbol
    end

    def path
      internal? ? "#{internal_root}/#{selector}" : selector
    end

    def exist?
      Dir.exist? path
    end

    def summary
      File.readlines(summary_file)[0].chomp
    end

    def readme
      File.read readme_file if File.exist? readme_file
    end

  private

    def render_script
      @render_script ||= File.read "#{path}/render.rb"
    end

    def internal_root
      self.class.internal_root
    end

    def summary_file
      "#{path}/summary.txt"
    end

    def readme_file
      "#{path}/README.md"
    end
  end
end
