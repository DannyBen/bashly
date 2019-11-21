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
    end
  end
end
