module Bashly
  class ConfigValidator
    include ValidationHelpers

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def validate
      assert_command 'root', data
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
      assert_hash key, value, keys: Script::CatchAll.option_keys
      assert_string "#{key}.label", value['label']
      assert_optional_string "#{key}.help", value['help']
      assert_boolean "#{key}.required", value['required']
    end

    def assert_default_command(key, value)
      return unless value

      assert [true, false, nil, 'force'].include?(value), "#{key} must be a boolean, or the string 'force'"
    end

    def assert_dependencies(key, value)
      return unless value

      case value
      when Array
        assert_array key, value, of: :string
      when Hash
        assert_dependencies_hash key, value
      else
        assert [Array, Hash].include?(value.class),
          "#{key} must be an array or a hash"
      end
    end

    def assert_dependencies_hash(key, value)
      value.each do |k, v|
        assert_dependency "#{key}.#{k}", v
      end
    end

    def assert_dependency(key, value)
      assert [String, Hash, NilClass].include?(value.class),
        "#{key} must be a string, a hash or nil"

      return unless value.is_a? Hash

      assert_hash key, value, keys: Script::Dependency.option_keys
      assert_string_or_array "#{key}.command", value['command']
      assert_optional_string "#{key}.help", value['help']
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
      assert_hash key, value, keys: Script::Argument.option_keys
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_string_or_array "#{key}.default", value['default']
      assert_optional_string "#{key}.validate", value['validate']
      assert_boolean "#{key}.required", value['required']
      assert_boolean "#{key}.repeatable", value['repeatable']
      assert_boolean "#{key}.unique", value['unique']

      assert_array "#{key}.allowed", value['allowed'], of: :string

      refute value['name'].match(/^-/), "#{key}.name must not start with '-'"

      refute value['required'] && value['default'], "#{key} cannot have both nub`required` and nub`default`"

      if value['unique']
        assert value['repeatable'], "#{key}.unique does not make sense without nub`repeatable`"
      end

      if value['default'].is_a? Array
        assert value['repeatable'], "#{key}.default array does not make sense without nub`repeatable`"
      end
    end

    def assert_flag(key, value)
      assert_hash key, value, keys: Script::Flag.option_keys
      assert value['short'] || value['long'], "#{key} must have at least one of nub`long` or nub`short`"

      refute value['allowed'] && value['completions'], "#{key} cannot have both nub`allowed` and nub`completions`"

      assert_optional_string "#{key}.long", value['long']
      assert_optional_string "#{key}.short", value['short']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.arg", value['arg']
      assert_string_or_array "#{key}.default", value['default']
      assert_optional_string "#{key}.validate", value['validate']

      assert_boolean "#{key}.private", value['private']
      assert_boolean "#{key}.repeatable", value['repeatable']
      assert_boolean "#{key}.unique", value['unique']
      assert_boolean "#{key}.required", value['required']
      assert_array "#{key}.allowed", value['allowed'], of: :string
      assert_array "#{key}.conflicts", value['conflicts'], of: :string
      assert_array "#{key}.completions", value['completions'], of: :string

      assert value['long'].match(/^--[a-zA-Z0-9_-]+$/), "#{key}.long must be in the form of '--name'" if value['long']
      assert value['short'].match(/^-[a-zA-Z0-9]$/), "#{key}.short must be in the form of '-n'" if value['short']
      refute value['arg'].match(/^-/), "#{key}.arg must not start with '-'" if value['arg']

      refute value['required'] && value['default'], "#{key} cannot have both nub`required` and nub`default`"

      if value['default']
        assert value['arg'], "#{key}.default does not make sense without nub`arg`"
      end

      if value['allowed']
        assert value['arg'], "#{key}.allowed does not make sense without nub`arg`"
      end

      if value['completions']
        assert value['arg'], "#{key}.completions does not make sense without nub`arg`"
      end

      if value['unique']
        assert value['arg'] && value['repeatable'],
          "#{key}.unique does not make sense without nub`arg` and nub`repeatable`"
      end

      if value['default'].is_a? Array
        assert value['repeatable'], "#{key}.default array does not make sense without nub`repeatable`"
      end
    end

    def assert_env_var(key, value)
      assert_hash key, value, keys: Script::EnvironmentVariable.option_keys
      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.default", value['default']
      assert_boolean "#{key}.required", value['required']
      assert_boolean "#{key}.private", value['private']
      assert_array "#{key}.allowed", value['allowed'], of: :string

      refute value['required'] && value['default'], "#{key} cannot have both nub`required` and nub`default`"
    end

    def assert_command(key, value)
      assert_hash key, value, keys: Script::Command.option_keys

      refute value['commands'] && value['args'], "#{key} cannot have both nub`commands` and nub`args`"
      refute value['commands'] && value['catch_all'], "#{key} cannot have both nub`commands` and nub`catch_all`"

      assert_string "#{key}.name", value['name']
      assert_optional_string "#{key}.help", value['help']
      assert_optional_string "#{key}.footer", value['footer']
      assert_optional_string "#{key}.group", value['group']
      assert_optional_string "#{key}.filename", value['filename']
      assert_optional_string "#{key}.function", value['function']

      assert_boolean "#{key}.private", value['private']
      assert_default_command "#{key}.default", value['default']
      assert_expose "#{key}.expose", value['expose']
      assert_version "#{key}.version", value['version']
      assert_catch_all "#{key}.catch_all", value['catch_all']
      assert_string_or_array "#{key}.alias", value['alias']
      assert_string_or_array "#{key}.examples", value['examples']
      assert_extensible "#{key}.extensible", value['extensible']
      assert_dependencies "#{key}.dependencies", value['dependencies']

      assert value['name'].match(/^[a-z0-9_\-.]+$/),
        "#{key}.name must only contain lowercase alphanumeric characters, hyphens, dots and underscores"

      refute value['name'].start_with?('-'), "#{key}.name must not start with a hyphen"

      assert_array "#{key}.args", value['args'], of: :arg
      assert_array "#{key}.flags", value['flags'], of: :flag
      assert_array "#{key}.commands", value['commands'], of: :command
      assert_array "#{key}.completions", value['completions'], of: :string
      assert_array "#{key}.filters", value['filters'], of: :string
      assert_array "#{key}.environment_variables", value['environment_variables'], of: :env_var

      assert_uniq "#{key}.commands", value['commands'], %w[name alias]
      assert_uniq "#{key}.flags", value['flags'], 'long'
      assert_uniq "#{key}.flags", value['flags'], 'short'
      assert_uniq "#{key}.args", value['args'], 'name'

      if value['function']
        assert value['function'].match(/^[a-z0-9_]+$/),
          "#{key}.function must contain lowercase alphanumeric characters and underscores only"
      end

      if value['catch_all'] && value['args']
        repeatable_arg = value['args'].find { |a| a['repeatable'] }&.dig 'name'
        refute repeatable_arg, "#{key}.catch_all makes no sense with repeatable arg (#{repeatable_arg})"
      end

      if value['args']
        repeatable_args = value['args'].count { |a| a['repeatable'] }
        assert repeatable_args < 2, "#{key}.args cannot have more than one repeatable args"

        if repeatable_args == 1
          assert value['args'].last['repeatable'],
            "#{key}.args cannot contain a repeatable arg unless it is the last one"
        end

        required_order = value['args'].map { |x| !!x['required'] }
        refute required_order.include_sequence?(false, true),
          "#{key}.args cannot contain required arg after optional arg"
      end

      if value['expose']
        assert value['commands'], "#{key}.expose makes no sense without nub`commands`"
      end

      if key == 'root'
        refute value['alias'], "#{key}.alias makes no sense"
        refute value['group'], "#{key}.group makes no sense"
        refute value['default'], "#{key}.default makes no sense"
        refute value['private'], "#{key}.private makes no sense"
        refute value['expose'], "#{key}.expose makes no sense"
      else
        refute value['version'], "#{key}.version makes no sense"
        refute value['extensible'], "#{key}.extensible makes no sense"
      end
    end
  end
end
