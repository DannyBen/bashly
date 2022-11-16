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

      def with_valid_config
        validate_config
        yield
        show_deprecations
      end

      def show_deprecations
        return if config_validator.deprecations.empty? || ENV['BASHLY_HIDE_DEPRECATIONS']

        messages = config_validator.deprecations.map(&:message).join("\n\n")
        say! "\n#{messages}\n\n"
      end
    end
  end
end
