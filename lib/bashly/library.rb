module Bashly
  class Library
    attr_reader :path, :config
    attr_accessor :args

    def initialize(path, config)
      @path = path.to_s
      @config = config
    end

    def files
      if custom_handler
        custom_handler.files

      else
        config['files'].map do |file|
          {
            path:    file['target'] % target_file_args,
            content: File.read("#{path}/#{file['source']}"),
          }
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
      files.find { |f| f[:path] == path }
    end

  private

    def custom_handler
      return nil unless config.is_a? String

      @custom_handler ||= Module.const_get(config).new(*args)
    end

    def target_file_args
      {
        user_source_dir: Settings.source_dir,
        user_target_dir: Settings.target_dir,
        user_lib_dir:    Settings.full_lib_dir,
        user_ext:        Settings.partials_extension,
      }
    end
  end
end
