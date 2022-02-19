module Bashly
  class MessageStrings
    include AssetHelper

    def [](key)
      values[key.to_s]
    end

    def values
      @values ||= values!
    end

  private

    def values!
      defaults = YAML.properly_load_file asset("templates/strings.yml")
      defaults.merge project_strings
    end

    def project_strings
      @project_strings ||= project_strings!
    end

    def project_strings!
      if File.exist? project_strings_path
        YAML.properly_load_file project_strings_path
      else
        {}
      end
    end

    def project_strings_path
      @project_strings_path ||= "#{Settings.source_dir}/bashly-strings.yml"
    end
  end
end
