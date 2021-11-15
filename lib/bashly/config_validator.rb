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
      assert [String, Integer, Float].include?(value.class),
        "#{key} must be a string or a number" 
    end

    def assert_catch_all(key, value)
      return unless value
      assert [TrueClass, String, Hash].include?(value.class),
        "#{key} must be a boolean, a string or a hash" 
    end

    def assert_extensible(key, value)
      return unless value
      assert [TrueClass, String].include?(value.class),
        "#{key} must be a boolean or a string" 
    end

    def assert_arg(key, value)
      assert_hash key, value
      assert_string "#{key}.name", value['name']
      assert_string "#{key}.help", value['help'] if value['help']
      assert_string "#{key}.default", value['default'] if value['default']
      assert_string "#{key}.validate", value['validate'] if value['validate']
      assert_boolean "#{key}.required", value['required']
      
      assert_array "#{key}.allowed", value['allowed'], of: :string
    end

    def assert_flag(key, value)
      assert_hash key, value
      assert value['short'] || value['long'], "#{key} must have at least one of long or short name"

      assert_string "#{key}.long", value['long'] if value['long']
      assert_string "#{key}.short", value['short'] if value['short']
      assert_string "#{key}.help", value['help'] if value['help']
      assert_string "#{key}.arg", value['arg'] if value['arg']

      assert_string "#{key}.default", value['default'] if value['default']
      assert_string "#{key}.validate", value['validate'] if value['validate']
      assert_boolean "#{key}.required", value['required']
      
      assert_array "#{key}.allowed", value['allowed'], of: :string
    end

    def assert_env_var(key, value)
      assert_hash key, value
      assert_string "#{key}.name", value['name']
      assert_string "#{key}.help", value['help'] if value['help']
      assert_string "#{key}.default", value['default'] if value['default']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_command(key, value)
      assert_hash key, value

      refute value['commands'] && value['args'], "#{key} cannot have both commands and args"
      refute value['commands'] && value['flags'], "#{key} cannot have both commands and flags"
      
      assert_string "#{key}.name", value['name']
      assert_string "#{key}.short", value['short'] if value['short']
      assert_string "#{key}.help", value['help'] if value['help']
      assert_string "#{key}.footer", value['footer'] if value['footer']
      assert_string "#{key}.group", value['group'] if value['group']
      assert_boolean "#{key}.default", value['default']
      
      assert_version "#{key}.version", value['version'] if value['version']
      assert_catch_all "#{key}.catch_all", value['catch_all']
      assert_extensible "#{key}.extensible", value['extensible']
      
      assert_array "#{key}.args", value['args'], of: :arg
      assert_array "#{key}.flags", value['flags'] , of: :flag
      assert_array "#{key}.commands", value['commands'], of: :command
      assert_array "#{key}.completions", value['completions'], of: :string
      assert_array "#{key}.dependencies", value['dependencies'], of: :string
      assert_array "#{key}.environment_variables", value['environment_variables'], of: :env_var
      assert_array "#{key}.examples", value['examples'], of: :string
    end
  end
end
