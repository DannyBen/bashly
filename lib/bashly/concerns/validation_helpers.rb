module Bashly
  # This is a `ConfigValidator` concern responsible for providing basic
  # assertion methods.
  module ValidationHelpers
  protected

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
      return unless of

      value.each_with_index do |val, i|
        send "assert_#{of}".to_sym, "#{key}[#{i}]", val
      end
    end

    def assert_hash(key, value, keys: nil)
      assert value.is_a?(Hash), "#{key} must be a hash"

      return unless keys

      invalid_keys = (value.keys.map(&:to_sym) - keys).reject { |k| k.start_with? 'x_' }
      assert invalid_keys.empty?, "#{key} contains invalid options: #{invalid_keys.join ', '}"
    end

    def assert_uniq(key, value, array_keys)
      return unless value

      array_keys = [array_keys] unless array_keys.is_a? Array
      list = []
      array_keys.each do |array_key|
        list += value.filter_map { |c| c[array_key] }.flatten
      end

      nonuniqs = list.nonuniq
      assert nonuniqs.empty?, "#{key} contains non-unique elements (#{nonuniqs.join ', '}) in #{array_keys.join ' or '}"
    end

    def assert_string_or_array(key, value)
      return unless value

      assert [Array, String].include?(value.class),
        "#{key} must be a string or an array"

      assert_array key, value, of: :string if value.is_a? Array
    end
  end
end
