module Bashly
  # A convenience class to use either a hash or a filename as a configuration
  # source.
  #
  # When a filename is provided, it is loaded with these extra features:
  # - Support for `import` keyword to merge additional YAML files
  # - Preprocessing with ERB
  class Config
    using ComposeRefinements

    attr_reader :config

    def self.new(config)
      if config.is_a? String
        YAML.load_erb_file(config).compose
      else
        config
      end
    end
  end
end
