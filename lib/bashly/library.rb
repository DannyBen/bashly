module Bashly
  class Library
    attr_reader :path, :config, :upgrade_string
    attr_accessor :args

    def initialize(path, config, upgrade_string: nil)
      @path = path.to_s
      @config = config
      @upgrade_string = upgrade_string
    end

    def files
      if custom_handler
        custom_handler.files

      else
        config['files'].map do |file|
          {
            path:    file['target'] % target_file_args,
            content: file_contents("#{path}/#{file['source']}"),
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
      return nil unless config['handler']

      @custom_handler ||= Module.const_get(config['handler']).new(*args)
    end

    def file_contents(path)
      File.read(path).sub('[@bashly-upgrade]', "[@bashly-upgrade #{upgrade_string}]")
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
