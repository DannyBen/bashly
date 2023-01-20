module Bashly
  class Deprecation
    attr_reader :old, :replacement, :reference

    def initialize(old, replacement: nil, reference: nil)
      @old = old
      @replacement = replacement
      @reference = reference
    end

    def message
      result = ['Deprecation Warning:', "r`#{old}` is deprecated"]
      result.push "use g`#{replacement}` instead" if replacement
      result.push "see bu`#{reference}`" if reference

      result.map { |line| "r`▐` #{line}" }.join("\n")
    end

    def to_h
      {
        old:         old,
        replacement: replacement,
        reference:   reference,
      }
    end
  end
end
