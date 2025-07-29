module Bashly
  # A helper class, used by the `String#lint` extension.
  # It will remove consecutive newlines and hidden comments from a string
  # unless the line is within a heredoc block.
  class LintHelper
    attr_reader :lines, :output, :marker

    def initialize(script)
      @lines = script.lines
      @output = []
      @marker = nil
      @previous_blank = false
    end

    def lint
      lines.each { |line| process_line line }
      output.join
    end

  private

    def process_line(line)
      if inside_heredoc?
        handle_heredoc_line line
      else
        handle_regular_line line
      end
    end

    def handle_heredoc_line(line)
      output << line
      reset_marker if heredoc_closed? line
    end

    def handle_regular_line(line)
      set_heredoc_state line
      return handle_blank_line if blank? line
      return if comment? line

      output << line
      @previous_blank = false
    end

    def handle_blank_line
      return if @previous_blank

      output << "\n"
      @previous_blank = true
    end

    def blank?(line)
      line.strip.empty?
    end

    def comment?(line)
      line =~ /^\s*##/
    end

    def set_heredoc_state(line)
      @marker = extract_heredoc_marker line unless inside_heredoc?
    end

    def extract_heredoc_marker(line)
      line =~ /<<-?\s*['"]?(\w+)['"]?/ ? $1 : nil
    end

    def inside_heredoc?
      !!marker
    end

    def heredoc_closed?(line)
      line.strip == marker
    end

    def reset_marker
      @marker = nil
    end
  end
end
