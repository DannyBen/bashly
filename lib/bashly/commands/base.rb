require 'mister_bin'
require 'fileutils'

module Bashly
  module Commands
    class Base < MisterBin::Command
      include AssetHelper

      def config
        @config ||= Config.new Settings.config_path
      end

      def config_validator
        @config_validator ||= ConfigValidator.new config
      end

      def validate_config
        config_validator.validate
      end

      def with_valid_config
        validate_config
        yield
      end
    end
  end
end
