class Array
  def indent(offset)
    return self unless offset.positive?

    indentation = ' ' * offset
    heredoc_marker = nil

    map do |line|
      if line =~ /<<-?(\w+)\n$/
        heredoc_marker = $1
        "#{indentation}#{line}"
      elsif heredoc_marker && line.include?(heredoc_marker)
        heredoc_marker = nil
        line
      else
        heredoc_marker ? line : "#{indentation}#{line}"
      end
    end
  end

  def nonuniq
    tally.select { |_key, count| count > 1 }.keys
  end
end
