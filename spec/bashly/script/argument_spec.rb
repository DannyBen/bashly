describe Script::Argument do
  subject do
    options = load_fixture('script/arguments')[fixture]
    described_class.new options
  end

  let(:fixture) { :basic_argument }

  describe '#default_string' do
    context 'when default is an array' do
      let(:fixture) { :default_array }

      it 'returns a shell-escaped string suitable to be shell array source' do
        expect(subject.default_string).to eq 'spaced\\ one two'
      end
    end

    context 'when default is string and repeatable is false' do
      let(:fixture) { :default_string }

      it 'returns it as is' do
        expect(subject.default_string).to eq 'spaced one'
      end
    end

    context 'when default is string and repeatable is true' do
      let(:fixture) { :default_string_with_repeatable }

      it 'returns a single string' do
        expect(subject.default_string).to eq 'spaced\\ one'
      end
    end
  end

  describe '#usage_string' do
    it 'returns a string suitable to be used as a usage pattern' do
      expect(subject.usage_string).to eq '[FILE]'
    end

    context 'when the argument is required' do
      let(:fixture) { :required }

      it 'returns a string suitable to be used as a usage pattern' do
        expect(subject.usage_string).to eq 'FILE'
      end
    end
  end

  describe '#label' do
    it 'returns a string suitable to be used as a compact usage pattern' do
      expect(subject.label).to eq 'FILE'
    end

    context 'with a repeatable arg' do
      let(:fixture) { :repeatable }

      it 'adds a ... suffix' do
        expect(subject.label).to eq 'FILE...'
      end
    end
  end
end
