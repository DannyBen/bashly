class Array
  def indent(offset)
    return self unless offset > 0
    indentation = " " * offset
    map { |line| "#{indentation}#{line}" }
  end

  def nonuniq
    tally.select { |key, count| count > 1 }.keys
  end

end
