class Array
  def indent offset
    return self unless offset.positive?
    indentation = " " * offset
    map { |line| "#{indentation}#{line}" }
  end

  def nonuniq
    tally.select { |_key, count| count > 1 }.keys
  end
end
