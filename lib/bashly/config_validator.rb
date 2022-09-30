module Bashly
  class ConfigValidator
    include ValidationHelpers

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def validate
      assert_command "root", data
    end

  private

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
      assert_hash key, value, Script::CatchAll.option_keys
      assert_string "#{key}.label", value['label']
      assert_optional_string "#{key}.help", value['help']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_extensible(key, value)
      return unless value
      assert [TrueClass, String].include?(value.class),
        "#{key} must be a boolean or a string" 
    end

    def assert_expose(key, value)
      return unless value
      assert [true, false, nil, 'always'].include?(value), "#{key} must be a boolean, or the string 'always'" 
    end

    def assert_arg(key, value)
      assert_hash key, value, Script::Argument.option_keys
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
      assert_hash key, value, Script::Flag.option_keys
      assert value['short'] || value['long'], "#{key} must have at least one of long or short name"

      refute value['allowed'] && value['completions'], "#{key} cannot have both allowed and completions"

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
      assert_array "#{key}.completions", value['completions'], of: :string

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

      if value['completions']
        assert value['arg'], "#{key}.completions does not make sense without arg"
      end
    end

    def assert_env_var(key, value)
      assert_hash key, value, Script::EnvironmentVariable.option_keys
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.default", value['default']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_command(key, value)
      assert_hash key, value, Script::Command.option_keys

      refute value['commands'] && value['args'], "#{key} cannot have both commands and args"
      refute value['commands'] && value['catch_all'], "#{key} cannot have both commands and catch_all"

      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.footer", value['footer']
      assert_optional_string "#{key}.group", value['group']
      assert_optional_string "#{key}.filename", value['filename']

      assert_boolean "#{key}.private", value['private']
      assert_boolean "#{key}.default", value['default']
      assert_expose "#{key}.expose", value['expose']
      assert_version "#{key}.version", value['version']
      assert_catch_all "#{key}.catch_all", value['catch_all']
      assert_string_or_array "#{key}.alias", value['alias']
      assert_extensible "#{key}.extensible", value['extensible']
      
      assert_array "#{key}.args", value['args'], of: :arg
      assert_array "#{key}.flags", value['flags'] , of: :flag
      assert_array "#{key}.commands", value['commands'], of: :command
      assert_array "#{key}.completions", value['completions'], of: :string
      assert_array "#{key}.dependencies", value['dependencies'], of: :string
      assert_array "#{key}.filters", value['filters'], of: :string
      assert_array "#{key}.environment_variables", value['environment_variables'], of: :env_var
      assert_array "#{key}.examples", value['examples'], of: :string

      assert_uniq "#{key}.commands", value['commands'], ['name', 'alias']
      assert_uniq "#{key}.flags", value['flags'], 'long'
      assert_uniq "#{key}.flags", value['flags'], 'short'
      assert_uniq "#{key}.args", value['args'], 'name'

      if value['default']
        assert value['args'], "#{key}.default makes no sense without args"
      end

      if value['catch_all'] and value['args']
        repeatable_arg = value['args'].select { |a| a['repeatable'] }.first&.dig 'name'
        refute repeatable_arg, "#{key}.catch_all makes no sense with repeatable arg (#{repeatable_arg})"
      end

      if value['expose']
        assert value['commands'], "#{key}.expose makes no sense without commands"
      end

      if key == "root"
        refute value['alias'], "#{key}.alias makes no sense"
        refute value['group'], "#{key}.group makes no sense"
        refute value['default'], "#{key}.default makes no sense"
        refute value['private'], "#{key}.private makes no sense"
        refute value['expose'], "#{key}.expose makes no sense"
      else
        refute value['version'], "#{key}.version makes no sense"
        refute value['extensible'], "#{key}.extensible makes no sense"
      end

      # DEPRECATION 0.8.0
      if value['short']
        deprecate "#{key}.short", replacement: "alias", reference: "https://github.com/DannyBen/bashly/pull/220"
      end
    end
  end
end
