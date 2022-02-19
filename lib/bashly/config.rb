require 'yaml'

module Bashly
  # A convenience class to use either a hash or a filename as a configuration
  # source
  class Config
    using ComposeRefinements

    attr_reader :config

    def self.new(config)
      if config.is_a? String
        YAML.properly_load_file(config).compose
      else
        config
      end
    end
  end
end