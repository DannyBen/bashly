require 'bashly/concerns/indentation_helper'

class Array
  def indent(offset)
    return self unless offset.positive?

    indentation = ' ' * offset
    indenter = Bashly::IndentationHelper.new indentation

    map { |line| indenter.indent line }
  end

  def nonuniq
    tally.select { |_key, count| count > 1 }.keys
  end

  def include_sequence?(*elements)
    return false if elements.empty?

    each_cons(elements.size).any?(elements)
  end
end
