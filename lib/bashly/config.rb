require 'yaml'

module Bashly
  # A convenience class to use either a hash or a filename as a configuration
  # source
  class Config
    attr_reader :config

    def self.new(config)
      if config.is_a? String
        YAML.load_file config
      else
        config
      end
    end
  end
end