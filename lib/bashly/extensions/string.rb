class String
  def sanitize_for_print
    gsub("\n", "\\n").gsub("\"", "\\\"")
  end

  def indent(offset)
    return self unless offset > 0
    split("\n").indent(offset).join("\n")
  end

  def to_underscore
    gsub(/(.)([A-Z])/,'\1_\2').gsub(/[\- ]/, '_').downcase
  end

  def wrap(length = 80)
    strip!
    split("\n").collect! do |line|
      if line.length > length
        line.gsub!(/([^\s]{#{length}})([^\s$])/, "\\1 \\2")
        line.gsub(/(.{1,#{length}})(\s+|$)/, "\\1\n").rstrip
      else
        line
      end
    end * "\n"
  end

  def lint
    gsub(/\n{2,}/, "\n\n")
  end

end
