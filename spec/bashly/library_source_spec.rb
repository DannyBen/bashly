require 'spec_helper'

describe LibrarySource do
  describe '#config' do
    it 'returns the contents of the libraries.yml file' do
      expect(subject.config).to be_a Hash
      expect(subject.config.keys.first).to eq 'colors'
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
      expect(subject.libraries.values.map { |a| a.class }.uniq ).to eq [Library]
    end
  end
end
