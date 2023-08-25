describe LibrarySource do
  subject { described_class.new uri }

  let(:uri) { nil }

  after(:all) { described_class.new.cleanup }

  describe '#uri' do
    context 'when it starts with github:' do
      let(:uri) { 'github:user/repo//the-path@the-ref' }

      it 'is transformed to git over https' do
        expect(subject.uri).to eq 'git:https://github.com/user/repo.git//the-path@the-ref'
      end
    end

    context 'when it starts with github-ssh:' do
      let(:uri) { 'github-ssh:user/repo//the-path@the-ref' }

      it 'is transformed to git over ssh' do
        expect(subject.uri).to eq 'git:git@github.com:user/repo.git//the-path@the-ref'
      end
    end
  end

  describe '#git?' do
    it 'returns false' do
      expect(subject).not_to be_git
    end

    context 'when the uri starts with git:' do
      let(:uri) { 'git:/repo' }

      it 'returns true' do
        expect(subject).to be_git
      end
    end

    context 'when the uri starts with github:' do
      let(:uri) { 'github:/repo' }

      it 'returns true' do
        expect(subject).to be_git
      end
    end

    context 'when the uri starts with github-ssh:' do
      let(:uri) { 'github-ssh:/repo' }

      it 'returns true' do
        expect(subject).to be_git
      end
    end
  end

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

  describe '#config_path' do
    it 'returns the path to libraries.yml' do
      expect(subject.config_path).to eq "#{subject.uri}/libraries.yml"
    end

    context 'with a git source' do
      let(:uri) { 'github:dannyben/bashly//spec/fixtures/libraries@0058d77' }

      it 'clones the repo to a temp directory and returns its path' do
        expect(subject.config_path).to match %r{/tmp/bashly-libs-.*/spec/fixtures/libraries/libraries.yml}
      end
    end

    context 'with a directory that does not contain libraries.yml' do
      let(:uri) { 'spec' }

      it 'raises an error' do
        expect { subject.config_path }.to raise_error('Cannot find spec/libraries.yml')
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
        help hooks ini lib settings strings test validations yaml
        render_markdown render_mandoc
      ]
    end

    it 'returns Library objects as values' do
      expect(subject.libraries.values.map(&:class).uniq).to eq [Library]
    end

    context 'with a custom source' do
      let(:uri) { 'spec/fixtures/libraries' }

      it 'replaces [@bashly-upgrade] marker with a proper upgrade string' do
        expect(subject.libraries[:database].files.first[:content])
          .to start_with '## [@bashly-upgrade spec/fixtures/libraries;database]'
      end
    end
  end

  describe '#cleanup' do
    it 'remoces all /tmp/bashly-libs-* directories' do
      expect(FileUtils).to receive(:rm_rf).with("#{Dir.tmpdir}/bashly-libs-*")
      subject.cleanup
    end
  end
end
