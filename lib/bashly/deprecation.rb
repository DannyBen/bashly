module Bashly
  class Deprecation
    attr_reader :old, :replacement, :reference

    def initialize(old, replacement: nil, reference: nil)
      @old, @replacement, @reference = old, replacement, reference
    end

    def message
      result = ["Deprecation Warning:", "!txtred!#{old}!txtrst! is deprecated"]
      result.push "use !txtgrn!#{replacement}!txtrst! instead" if replacement
      result.push "see !undblu!#{reference}!txtrst!" if reference
      
      result.map { |line| "!txtred!▐!txtrst! #{line}"}.join("\n")
    end

    def to_h
      {
        old: old,
        replacement: replacement,
        reference: reference
      }
    end
  end
end