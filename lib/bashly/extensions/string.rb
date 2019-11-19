require 'erb'
require 'ostruct'

class String
  def indent(offset)
    return self unless offset > 0
    split("\n").indent(offset).join("\n")
  end

  def to_underscore!
    gsub!(/(.)([A-Z])/,'\1_\2')
    gsub!(' ', '_')
    downcase!
  end

  def to_underscore
    dup.tap { |s| s.to_underscore! }
  end

end
