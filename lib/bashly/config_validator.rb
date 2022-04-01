module Bashly
  class ConfigValidator
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def validate
      assert_command "root", data
    end

  private

    def assert(valid, message)
      raise ConfigurationError, message unless valid
    end

    def refute(invalid, message)
      assert !invalid, message
    end

    def assert_string(key, value)
      assert value.is_a?(String), "#{key} must be a string"
    end

    def assert_optional_string(key, value)
      assert_string key, value if value
    end

    def assert_boolean(key, value)
      assert [true, false, nil].include?(value), "#{key} must be a boolean" 
    end

    def assert_array(key, value, of: nil)
      return unless value
      assert value.is_a?(Array), "#{key} must be an array"
      if of
        value.each_with_index do |val, i|
          send "assert_#{of}".to_sym, "#{key}[#{i}]", val
        end
      end
    end

    def assert_hash(key, value)
      assert value.is_a?(Hash), "#{key} must be a hash"
    end

    def assert_version(key, value)
      return unless value
      assert [String, Integer, Float].include?(value.class),
        "#{key} must be a string or a number" 
    end

    def assert_catch_all(key, value)
      return unless value
      assert [TrueClass, String, Hash].include?(value.class),
        "#{key} must be a boolean, a string or a hash" 

      assert_catch_all_hash key, value if value.is_a? Hash
    end

    def assert_catch_all_hash(key, value)
      assert_string "#{key}.label", value['label']
      assert_optional_string "#{key}.help", value['help']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_extensible(key, value)
      return unless value
      assert [TrueClass, String].include?(value.class),
        "#{key} must be a boolean or a string" 
    end

    def assert_arg(key, value)
      assert_hash key, value
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.default", value['default']
      assert_optional_string "#{key}.validate", value['validate']
      assert_boolean "#{key}.required", value['required']
      assert_boolean "#{key}.repeatable", value['repeatable']
      
      assert_array "#{key}.allowed", value['allowed'], of: :string

      refute value['name'].match(/^-/), "#{key}.name must not start with '-'"

      refute value['required'] && value['default'], "#{key} cannot have both required and default"
    end

    def assert_flag(key, value)
      assert_hash key, value
      assert value['short'] || value['long'], "#{key} must have at least one of long or short name"

      assert_optional_string "#{key}.long", value['long']
      assert_optional_string "#{key}.short", value['short']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.arg", value['arg']
      assert_optional_string "#{key}.default", value['default']
      assert_optional_string "#{key}.validate", value['validate']
      
      assert_boolean "#{key}.repeatable", value['repeatable']
      assert_boolean "#{key}.required", value['required']
      assert_array "#{key}.allowed", value['allowed'], of: :string
      assert_array "#{key}.conflicts", value['conflicts'], of: :string

      assert value['long'].match(/^--[a-zA-Z0-9_\-]+$/), "#{key}.long must be in the form of '--name'" if value['long']
      assert value['short'].match(/^-[a-zA-Z0-9]$/), "#{key}.short must be in the form of '-n'" if value['short']
      refute value['arg'].match(/^-/), "#{key}.arg must not start with '-'" if value['arg']

      refute value['required'] && value['default'], "#{key} cannot have both required and default"

      if value['default']
        assert value['arg'], "#{key}.default does not make sense without arg"
      end

      if value['allowed']
        assert value['arg'], "#{key}.allowed does not make sense without arg"
      end
    end

    def assert_env_var(key, value)
      assert_hash key, value
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.default", value['default']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_command(key, value)
      assert_hash key, value

      refute value['commands'] && value['args'], "#{key} cannot have both commands and args"
      refute value['commands'] && value['flags'], "#{key} cannot have both commands and flags"
      
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.short", value['short']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.footer", value['footer']
      assert_optional_string "#{key}.group", value['group']
      assert_optional_string "#{key}.filename", value['filename']

      assert_boolean "#{key}.default", value['default']
      assert_version "#{key}.version", value['version']
      assert_catch_all "#{key}.catch_all", value['catch_all']
      assert_extensible "#{key}.extensible", value['extensible']
      
      assert_array "#{key}.args", value['args'], of: :arg
      assert_array "#{key}.flags", value['flags'] , of: :flag
      assert_array "#{key}.commands", value['commands'], of: :command
      assert_array "#{key}.completions", value['completions'], of: :string
      assert_array "#{key}.dependencies", value['dependencies'], of: :string
      assert_array "#{key}.filters", value['filters'], of: :string
      assert_array "#{key}.environment_variables", value['environment_variables'], of: :env_var
      assert_array "#{key}.examples", value['examples'], of: :string

      if key == "root"
        refute value['short'], "#{key}.short makes no sense"
        refute value['group'], "#{key}.group makes no sense"
        refute value['default'], "#{key}.default makes no sense"
        refute value['private'], "#{key}.private makes no sense"
      else
        refute value['version'], "#{key}.version makes no sense"
        refute value['extensible'], "#{key}.extensible makes no sense"
      end
    end
  end
end
