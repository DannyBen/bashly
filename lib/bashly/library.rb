module Bashly
  class Library
    class << self
      def exist?(name)
        config.has_key? name.to_s
      end

      def config
        @config ||= YAML.properly_load_file(config_path)
      end

      def config_path
        @config_path ||= File.expand_path 'libraries.yml', __dir__
      end
    end

    include AssetHelper
    attr_reader :name, :args

    def initialize(name, *args)
      @name, @args = name.to_s, args
    end

    def files
      if custom_handler
        custom_handler.files

      else
        config['files'].map do |file|
          { path: file['target'] % target_file_args,
            content: asset_content(file['source']) }
        end
      end
    end

    def post_install_message
      if custom_handler
        custom_handler.post_install_message
      else
        config['post_install_message']
      end
    end

    def find_file(path)
      files.select { |f| f[:path] == path }.first
    end

  private

    def custom_handler
      return nil unless config.is_a? Symbol
      @custom_handler ||= Bashly::Libraries.const_get(config).new(*args)
    end

    def config
      @config ||= self.class.config[name]
    end

    def target_file_args
      {
        user_source_dir: Settings.source_dir,
        user_target_dir: Settings.target_dir,
        user_lib_dir: Settings.full_lib_dir,
      }
    end
  end
end
