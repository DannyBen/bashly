describe YAML do
  describe '::load_erb_file' do
    let(:path) { 'spec/fixtures/erb/simple.yml' }

    it 'pre-processes the loaded YAML file with ERB' do
      expect(described_class.load_erb_file(path).to_yaml).to match_approval('extensions/yaml/load-erb-file')
    end
  end
end
