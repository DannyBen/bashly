describe Array do
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
  end

  describe '#nonuniq' do
    subject { %w[one it it two works three works] }

    it 'returns an array of non unique elements' do
      expect(subject.nonuniq).to eq %w[it works]
    end
  end

  describe '#include_sequence?' do
    it 'returns true when the array includes the sequence' do
      expect([1, 2, 3, 4].include_sequence?(2, 3)).to be true
    end

    it 'returns true when the array does not include the sequence' do
      expect([1, 2, 3, 4].include_sequence?(3, 2)).to be false
    end
  end
end
