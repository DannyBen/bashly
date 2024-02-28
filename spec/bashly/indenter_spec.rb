describe Indenter do
  # this is tested through the array extension for convenience
  subject { ['flat', '  indented', '    very indented'] }

  describe '#indent' do
    it 'prepends each element with the indentation string' do
      expect(subject.indent(2)).to eq ['  flat', '    indented', '      very indented']
    end

    context 'when offset is 0' do
      it 'returns the array as is' do
        expect(subject.indent(0)).to eq subject
      end
    end

    # context 'when the string contains heredoc block' do
    #   subject do
    #     result = <<~SUBJECT
    #       function() {
    #         cat <<-SOME_EOF_MARKER
    #       not-indented
    #         indented-once
    #           indented-twice
    #       SOME_EOF_MARKER
    #       } # indented with function() start
    #     SUBJECT

    #     result.lines
    #   end

    #   let(:expected) do
    #     result = <<~SUBJECT
    #         function() {
    #           cat <<-SOME_EOF_MARKER
    #       not-indented
    #         indented-once
    #           indented-twice
    #       SOME_EOF_MARKER
    #         } # indented with function() start
    #     SUBJECT

    #     result.lines
    #   end

    #   it 'does not indent it but indents everything else' do
    #     expect(subject.indent 2).to eq expected
    #   end
    # end
  end
end
