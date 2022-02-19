module Bashly
  class Settings
    class << self
      attr_writer :source_dir, :target_dir, :lib_dir, :strict

      def source_dir
        @source_dir ||= ENV['BASHLY_SOURCE_DIR'] || 'src'
      end

      def target_dir
        @target_dir ||= ENV['BASHLY_TARGET_DIR'] || '.'
      end

      def lib_dir
        @lib_dir ||= ENV['BASHLY_LIB_DIR'] || 'lib'
      end

      def strict
        @strict ||= ENV['BASHLY_STRICT']
      end

      def full_lib_dir
        "#{source_dir}/#{lib_dir}"
      end
    end
  end
end
