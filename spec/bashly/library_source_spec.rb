require 'spec_helper'

describe LibrarySource do
  describe '#config' do
    it 'returns the contents of the libraries.yml file' do
      expect(subject.config).to be_a Hash
      expect(subject.config.keys.first).to eq 'colors'
    end

    context 'with an external path' do
      subject { described_class.new path }

      let(:path) { 'spec/fixtures/libraries' }

      it 'reads the config from the specified path' do
        expect(subject.config).to be_a Hash
        expect(subject.config.keys).to eq ['database']
      end
    end
  end

  describe '#libraries' do
    it 'returns a hash' do
      expect(subject.libraries).to be_a Hash
    end

    it 'returns all libraries as keys' do
      expect(subject.libraries.keys).to match_array %i[
        colors completions completions_script completions_yaml config
        help lib settings strings test validations yaml
      ]
    end

    it 'returns Library objects as values' do
      expect(subject.libraries.values.map(&:class).uniq).to eq [Library]
    end
  end
end
