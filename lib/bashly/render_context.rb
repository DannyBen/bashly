require 'date' # for use by template render scripts
require 'colsole'

module Bashly
  class RenderContext
    include Colsole

    attr_reader :source, :target, :show
    attr_writer :config

    def initialize(source:, target:, show: nil)
      @source = source
      @target = target
      @show = show
    end

    def config
      @config ||= Config.new Settings.config_path
    end

    def command
      @command ||= Script::Command.new config
    end

    def save(filename, content)
      File.deep_write filename, content
      say "g`saved` #{filename}"
    end
  end
end
