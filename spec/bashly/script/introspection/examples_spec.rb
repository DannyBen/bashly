describe Script::Introspection::Examples do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#examples' do
    context 'when there are no examples' do
      it 'returns nil' do
        expect(subject.examples).to be_nil
      end
    end

    context 'when there are examples as array' do
      let(:fixture) { :examples_array }

      it 'returns the array' do
        expect(subject.examples).to be_an Array
      end
    end

    context 'when there are examples as string' do
      let(:fixture) { :examples_string }

      it 'returns an array with one item' do
        expect(subject.examples).to be_an Array
        expect(subject.examples.count).to eq 1
        expect(subject.examples.first).to start_with 'Download a file'
      end
    end
  end
end
