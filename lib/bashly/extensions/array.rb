class Array
  def indent(offset)
    return self unless offset.positive?

    indentation = ' ' * offset
    heredoc_marker = nil

    map do |line|
      if heredoc_marker
        heredoc_marker = nil if /^#{heredoc_marker}\n?/.match?(line)
        line
      elsif line =~ /<<-?(\w+)\n?$/
        heredoc_marker = $1
        "#{indentation}#{line}"
      else
        "#{indentation}#{line}"
      end
    end
  end

  def nonuniq
    tally.select { |_key, count| count > 1 }.keys
  end
end
