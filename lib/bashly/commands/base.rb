require 'mister_bin'
require 'fileutils'

module Bashly
  module Commands
    class Base < MisterBin::Command
      include AssetHelper

      def validate_config
        config = Config.new "#{Settings.source_dir}/bashly.yml"
        validator = ConfigValidator.new config
        validator.validate
      end
    end
  end
end
