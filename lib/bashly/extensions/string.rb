class String
  def sanitize_for_print
    gsub("\n", '\\n').gsub('"', '\"').gsub('`', '\\\\`').gsub('%', '%%')
  end

  def for_markdown
    gsub('<', '\\<').gsub('>', '\\>').nl2br
  end

  def for_manpage
    gsub('<', '\\<').gsub('>', '\\>').gsub('`', '**').gsub("  \n", "\n\n")
  end

  def nl2br
    gsub("\n", "  \n")
  end

  def indent(offset)
    return self unless offset.positive?

    lines.indent(offset).join
  end

  def to_underscore
    gsub(/(.)([A-Z])/, '\1_\2').gsub(/[- ]/, '_').downcase
  end

  def to_hyphen
    tr(' ', '-').gsub(/([a-z])([A-Z])/, '\1-\2').downcase
  end

  def to_path
    tr(' ', '/').downcase
  end

  def wrap(length = 80)
    strip!
    split("\n").collect! do |line|
      if line.length > length
        line.gsub(/(.{1,#{length}})(\s+|$)/, "\\1\n").rstrip
      else
        line
      end
    end * "\n"
  end

  def lint
    Bashly::LintHelper.new(self).lint
  end

  def remove_front_matter
    split(/^---\s*/).last
  end

  def expand_tabs(tabstop = 2)
    gsub(/^( {#{tabstop}}+)/) do
      "\t" * (::Regexp.last_match(1).size / tabstop)
    end
  end

  def color(marker)
    color = Bashly::Settings.usage_colors[marker.to_s]
    return self unless color

    text, spaces = match(/(.*?)(\s*)$/).captures
    %[$(#{color} "#{text}")#{spaces}]
  end
end
