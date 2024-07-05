module Bashly
  class Settings
    class << self
      include AssetHelper

      attr_writer(
        :commands_dir,
        :compact_short_flags,
        :conjoined_flag_args,
        :config_path,
        :lib_dir,
        :partials_extension,
        :show_examples_on_error,
        :source_dir,
        :strict,
        :tab_indent,
        :target_dir,
        :usage_colors
      )

      def commands_dir
        @commands_dir ||= get :commands_dir
      end

      def compact_short_flags
        @compact_short_flags ||= get :compact_short_flags
      end

      def conjoined_flag_args
        @conjoined_flag_args ||= get :conjoined_flag_args
      end

      def config_path
        @config_path ||= get(:config_path) % { source_dir: source_dir }
      end

      def env
        @env ||= get(:env)&.to_sym
      end

      def env=(value)
        @env = value&.to_sym
      end

      def full_lib_dir
        "#{source_dir}/#{lib_dir}"
      end

      def lib_dir
        @lib_dir ||= get :lib_dir
      end

      def partials_extension
        @partials_extension ||= get :partials_extension
      end

      def production?
        env == :production
      end

      def show_examples_on_error
        @show_examples_on_error ||= get :show_examples_on_error
      end

      def source_dir
        @source_dir ||= get :source_dir
      end

      def strict
        @strict ||= get :strict
      end

      def strict_string
        if strict.is_a? String
          strict
        elsif strict
          'set -euo pipefail'
        else
          'set -e'
        end
      end

      def tab_indent
        @tab_indent ||= get :tab_indent
      end

      def target_dir
        @target_dir ||= get :target_dir
      end

      def usage_colors
        @usage_colors ||= get :usage_colors
      end

    private

      def get(key)
        case env_value key
        when nil                 then config[key.to_s]
        when '0', 'false', 'no'  then false
        when '1', 'true', 'yes'  then true
        else                     env_value key
        end
      end

      def env_value(key)
        ENV["BASHLY_#{key.upcase}"]
      end

      def config
        @config ||= defsult_settings.merge user_settings
      end

      def user_settings
        @user_settings ||= File.exist?(user_settings_path) ? Config.new(user_settings_path) : {}
      end

      def user_settings_path
        @user_settings_path ||= if ENV['BASHLY_SETTINGS_PATH']
          ENV['BASHLY_SETTINGS_PATH']
        elsif File.exist? 'bashly-settings.yml'
          'bashly-settings.yml'
        else
          'settings.yml'
        end
      end

      def defsult_settings
        @defsult_settings ||= Config.new default_settings_path
      end

      def default_settings_path
        asset 'libraries/settings/settings.yml'
      end
    end
  end
end
