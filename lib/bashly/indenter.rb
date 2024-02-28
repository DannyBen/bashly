# A helper class, used by the `Array#indent` extension.
# It will return the array of strings with all strings prefixed by `indentation`
# unless the line is within a heredoc block.
class Indenter
  attr_reader :marker, :indentation

  def initialize(indentation)
    @indentation = indentation
    @marker = nil
  end

  def indent(line)
    if inside_heredoc?
      reset_marker if heredoc_closed?(line)
      line
    else
      set_heredoc_state(line)
      "#{indentation}#{line}"
    end
  end

private

  def reset_marker
    @marker = nil
  end

  def inside_heredoc?
    !!marker
  end

  def set_heredoc_state(line)
    @marker = extract_heredoc_marker(line)
  end

  def extract_heredoc_marker(line)
    line =~ /<<-?\s*(\w+)/ ? $1 : nil
  end

  def heredoc_closed?(line)
    inside_heredoc? && /^#{marker}\n?$/.match?(line)
  end
end
