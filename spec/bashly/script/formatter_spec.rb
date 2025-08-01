describe Script::Formatter do
  subject { described_class.new script, mode: mode }

  let(:script) { File.read "spec/fixtures/formatter/#{script_id}.sh" }
  let(:script_id) { :simple }
  let(:mode) { nil }

  describe '#formatted_script' do
    it 'formats the script using the internal formatter' do
      expect(subject.formatted_script).to match_approval 'formatter/internal'
    end

    context 'with mode: none' do
      let(:mode) { 'none' }

      it 'returns the original script' do
        expect(subject.formatted_script).to eq script
      end
    end

    context 'with mode: external' do
      let(:mode) { 'external' }

      it 'uses shfmt to format the script' do
        expect(subject.formatted_script).to match_approval 'formatter/shfmt'
      end
    end

    context 'with mode: shfmt (string)' do
      let(:mode) { 'shfmt --func-next-line' }

      it 'uses the given command shfmt to format the script' do
        expect(subject.formatted_script).to match_approval 'formatter/shfmt-custom'
      end
    end

    context 'when the external command does not exist' do
      let(:mode) { 'my_formatter' }

      it 'raises a Bashly::Error' do
        expect { subject.formatted_script }.to raise_approval 'formatter/error-not-found'
      end
    end

    context 'when the external command fails' do
      let(:mode) { 'shfmt --diff' }

      it 'raises a a Bashly::Error' do
        expect { subject.formatted_script }.to raise_approval 'formatter/error-failure'
      end
    end
  end
end
