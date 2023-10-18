module Bashly
  class LibrarySourceConfig
    include ValidationHelpers

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def data
      @data ||= YAML.load_file path
    end

    def validated_data
      validate
      data
    end

    def validate
      assert_root path, data
    end

  private

    def assert_root(path, value)
      assert_hash path, value
      data.each { |id, spec| assert_lib "[#{path}] #{id}", spec }
    end

    def assert_lib(key, value)
      assert_string "#{key}.help", value['help']
      
      assert_optional_string "#{key}.usage", value['usage']
      assert_optional_string "#{key}.handler", value['handler']
      assert_optional_string "#{key}.post_install_message", value['post_install_message']

      return if value['handler']

      assert_array "#{key}.files", value['files'], of: :filespec
    end

    def assert_filespec(key, value)
      assert_string "#{key}.source", value['source']
      assert_string "#{key}.target", value['target']
    end
  end
end
