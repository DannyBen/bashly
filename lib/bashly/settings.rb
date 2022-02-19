module Bashly
  class Settings
    class << self
      attr_writer :source_dir, :target_dir, :strict

      def source_dir
        @source_dir ||= ENV['BASHLY_SOURCE_DIR'] || 'src'
      end

      def target_dir
        @target_dir ||= ENV['BASHLY_TARGET_DIR'] || '.'
      end

      def strict
        @strict ||= ENV['BASHLY_STRICT']
      end
    end
  end
end
