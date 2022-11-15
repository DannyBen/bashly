module Bashly
  class Settings
    class << self
      include AssetHelper

      attr_writer :compact_short_flags, :source_dir, :target_dir,
        :lib_dir, :strict, :tab_indent

      def source_dir
        @source_dir ||= get :source_dir
      end

      def target_dir
        @target_dir ||= get :target_dir
      end

      def lib_dir
        @lib_dir ||= get :lib_dir
      end

      def strict
        @strict ||= get :strict
      end

      def tab_indent
        @tab_indent ||= get :tab_indent
      end

      def compact_short_flags
        @compact_short_flags ||= get :compact_short_flags
      end

      def env
        @env ||= get(:env)&.to_sym
      end

      def env= value
        @env = value&.to_sym
      end

      def production?
        env == :production
      end

      def full_lib_dir
        "#{source_dir}/#{lib_dir}"
      end

      private

      def get key
        case env_value key
        when nil                 then config[key.to_s]
        when "0", "false", "no"  then false
        when "1", "true", "yes"  then true
        else                     env_value key
        end
      end

      def env_value key
        ENV["BASHLY_#{key.upcase}"]
      end

      def config
        @config ||= defsult_settings.merge user_settings
      end

      def user_settings
        @user_settings ||= File.exist?("settings.yml") ? Config.new("settings.yml") : {}
      end

      def defsult_settings
        @defsult_settings ||= Config.new default_settings_path
      end

      def default_settings_path
        asset "templates/settings.yml"
      end
    end
  end
end
