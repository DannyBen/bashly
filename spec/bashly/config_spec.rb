describe Config do
  subject { described_class.new config }

  let(:config) { { 'hello' => 'world' } }

  describe '::new' do
    it 'returns a hash (and not a Config object)' do
      expect(subject).to be_a Hash
    end
  end

  context 'with a hash argument' do
    it 'returns the hash' do
      expect(subject['hello']).to eq 'world'
    end
  end

  context 'with a string argument' do
    let(:config) { 'spec/fixtures/config.yml' }

    it 'treats the string as a path to YAML and loads it' do
      expect(subject['loaded']).to eq 'yes indeed'
    end

    context 'when the loaded YAML contains import directives' do
      let(:config) { 'spec/fixtures/import.yml' }

      it 'evaluates them' do
        expect(subject['commands'].first['loaded']).to eq 'yes indeed'
      end
    end

    context 'when the loaded YAML contains ERB and import directives' do
      let(:config) { 'spec/fixtures/erb/with_imports.yml' }

      it 'evaluates ERB and imports' do
        expect(subject.to_yaml).to match_approval('config/erb')
      end
    end
  end
end
