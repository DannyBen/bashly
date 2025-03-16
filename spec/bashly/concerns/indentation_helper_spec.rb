describe IndentationHelper do
  # Since `IndentationHelper` is a stateful class that operates on a
  # line-by-line basis, the `IndentationHelper#indent` method is tested via
  # the `Array#indent` extension for convenience and clarity.
  describe '#indent' do
    subject { ['root:', '  indented:'] }

    it 'prepends each element with spaces' do
      expect(subject.indent(2)).to eq ['  root:', '    indented:']
    end

    context 'when offset is 0' do
      it 'returns the array as is' do
        expect(subject.indent(0)).to eq subject
      end
    end

    context 'when the string contains heredoc block' do
      subject do
        result = <<~SUBJECT
          function() {
            cat <<-SOME_EOF_MARKER
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
          } # indented with function() start
        SUBJECT

        result.lines
      end

      let(:expected) do
        result = <<~SUBJECT
            function() {
              cat <<-SOME_EOF_MARKER
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
            } # indented with function() start
        SUBJECT

        result.lines
      end

      it 'does not indent it but indents everything else' do
        expect(subject.indent 2).to eq expected
      end
    end

    context 'when the string contains a single quoted heredoc block' do
      subject do
        result = <<~SUBJECT
          function() {
            cat <<-'SOME_EOF_MARKER'
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
          } # indented with function() start
        SUBJECT

        result.lines
      end

      let(:expected) do
        result = <<~SUBJECT
            function() {
              cat <<-'SOME_EOF_MARKER'
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
            } # indented with function() start
        SUBJECT

        result.lines
      end

      it 'does not indent it but indents everything else' do
        expect(subject.indent 2).to eq expected
      end
    end

    context 'when the string contains a double quoted heredoc block' do
      subject do
        result = <<~SUBJECT
          function() {
            cat <<-"SOME_EOF_MARKER"
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
          } # indented with function() start
        SUBJECT

        result.lines
      end

      let(:expected) do
        result = <<~SUBJECT
            function() {
              cat <<-"SOME_EOF_MARKER"
          not-indented
            indented-once
              indented-twice
          SOME_EOF_MARKER
            } # indented with function() start
        SUBJECT

        result.lines
      end

      it 'does not indent it but indents everything else' do
        expect(subject.indent 2).to eq expected
      end
    end
  end
end
