module Bashly
  class Settings
    class << self
      attr_writer :source_dir, :target_dir

      def source_dir
        @source_dir ||= ENV['BASHLY_SOURCE_DIR'] || 'src'
      end

      def target_dir
        @target_dir ||= ENV['BASHLY_TARGET_DIR'] || '.'
      end

      def strings
        @strings ||= strings!
      end

    private

      def strings!
        defaults = YAML.load_file strings_config_path
        defaults.merge project_strings
      end

      def project_strings
        @project_strings ||= project_strings!
      end

      def project_strings!
        if File.exist? project_strings_path
          YAML.load_file project_strings_path
        else
          {}
        end
      end

      def project_strings_path
        @project_strings_path ||= "#{source_dir}/bashly-settings.yml"
      end

      def strings_config_path
        File.expand_path "templates/strings.yml", __dir__
      end
    end
  end
end
