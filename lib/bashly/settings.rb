module Bashly
  class Settings
    class << self
      include AssetHelper
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
        defaults = YAML.load_file asset("templates/strings.yml")
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
        @project_strings_path ||= "#{source_dir}/bashly-strings.yml"
      end
    end
  end
end
