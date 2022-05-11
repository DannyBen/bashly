require 'mister_bin'
require 'fileutils'

module Bashly
  module Commands
    class Base < MisterBin::Command
      include AssetHelper

      def config
        @config ||= Config.new "#{Settings.source_dir}/bashly.yml"
      end

      def config_validator
        @config_validator ||= ConfigValidator.new config
      end

      def validate_config
        config_validator.validate
      end
    end
  end
end
