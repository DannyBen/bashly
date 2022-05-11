class Array
  def indent(offset)
    return self unless offset > 0
    indentation = " " * offset
    map { |line| "#{indentation}#{line}" }
  end

  def uniq?
    self == uniq
  end

end
