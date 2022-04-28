module Bashly
  class Settings
    class << self
      attr_writer :source_dir, :target_dir, :lib_dir, :strict, :tab_indent

      def source_dir
        @source_dir ||= get :source_dir, 'src'
      end

      def target_dir
        @target_dir ||= get :target_dir, '.'
      end

      def lib_dir
        @lib_dir ||= get :lib_dir, 'lib'
      end

      def strict
        @strict ||= get :strict
      end

      def tab_indent
        @tab_indent ||= get :tab_indent
      end

      def env
        @env ||= get(:env, :development)&.to_sym
      end

      def env=(value)
        @env = value&.to_sym
      end

      def production?
        env == :production
      end

      def full_lib_dir
        "#{source_dir}/#{lib_dir}"
      end

    private

      def get(key, default = nil)
        ENV["BASHLY_#{key.upcase}"] || user_settings[key.to_s] || default
      end

      def user_settings
        @user_settings ||= begin
          File.exist?('settings.yml') ? Config.new('settings.yml') : {}
        end
      end

    end
  end
end
