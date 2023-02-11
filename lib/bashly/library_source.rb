module Bashly
  class LibrarySource
    attr_reader :path

    def initialize(path = nil)
      @path = path || File.expand_path('libraries', __dir__)
    end

    def config
      @config ||= YAML.properly_load_file("#{path}/libraries.yml")
    end

    def libraries
      config.to_h do |name, spec|
        [name.to_sym, Library.new(path, spec)]
      end
    end
  end
end
