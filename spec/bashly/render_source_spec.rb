describe RenderSource do
  subject { described_class.new selector }

  let(:selector) { :markdown }
  let(:path_to_source) { 'lib/bashly/libraries/render/markdown' }

  describe '#internal?' do
    context 'with an internal source' do
      it 'returns true' do
        expect(subject).to be_internal
      end
    end

    context 'with an external source' do
      let(:selector) { path_to_source }

      it 'returns false' do
        expect(subject).not_to be_internal
      end
    end
  end

  describe '#path' do
    it "returns the path to the source's root directory" do
      expect(subject.path).to end_with path_to_source
    end
  end

  describe '#exist?' do
    context 'when the path exists' do
      it 'returns true' do
        expect(subject).to exist
      end
    end

    context 'when the path does not exist' do
      let(:selector) { 'no-such-source' }

      it 'returns false' do
        expect(subject).not_to exist
      end
    end
  end

  describe '#summary' do
    it 'returns the first line of the summary file' do
      expect(subject.summary).to eq File.readlines("#{path_to_source}/summary.txt")[0].chomp
    end
  end

  describe '#readme' do
    it 'returns the content of the readme file' do
      expect(subject.readme).to eq File.read("#{path_to_source}/README.md")
    end
  end
end
