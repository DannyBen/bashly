describe Script::Flag do
  subject do
    options = load_fixture('script/flags')[fixture]
    described_class.new options
  end

  let(:fixture) { :basic_flag }

  describe '#aliases' do
    context 'with long and short options' do
      it 'returns an array of both long and short values' do
        expect(subject.aliases).to eq ['--help', '-h']
      end
    end

    context 'with long option only' do
      let(:fixture) { :long_only }

      it 'returns an array with the long value' do
        expect(subject.aliases).to eq ['--long']
      end
    end

    context 'with short option only' do
      let(:fixture) { :short_only }

      it 'returns an array with the short value' do
        expect(subject.aliases).to eq ['-s']
      end
    end
  end

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

  describe '#name' do
    context 'with both short and long options' do
      it 'returns the long option' do
        expect(subject.name).to eq '--help'
      end
    end

    context 'with long option only' do
      let(:fixture) { :long_only }

      it 'returns the long option' do
        expect(subject.name).to eq '--long'
      end
    end

    context 'with short option only' do
      let(:fixture) { :short_only }

      it 'returns the short option' do
        expect(subject.name).to eq '-s'
      end
    end
  end

  describe '#usage_string' do
    it 'returns a string suitable to be used as a usage pattern' do
      expect(subject.usage_string).to eq '--help, -h'
    end

    context 'with extended: true' do
      context 'when the flag is optional' do
        it 'returns the same string as it does without extended' do
          expect(subject.usage_string(extended: true)).to eq subject.usage_string
        end
      end

      context 'when the flag is also required' do
        let(:fixture) { :required }

        it 'appends (required) to the usage string' do
          expect(subject.usage_string(extended: true)).to eq "#{subject.usage_string} (required)"
        end
      end

      context 'when the flag is also repeatable' do
        let(:fixture) { :repeatable }

        it 'appends (repeatable) to the usage string' do
          expect(subject.usage_string(extended: true)).to eq "#{subject.usage_string} (repeatable)"
        end
      end
    end
  end
end
