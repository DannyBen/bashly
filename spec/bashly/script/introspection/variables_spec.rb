describe Script::Introspection::Variables do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :variables }

  describe '#variables' do
    it 'returns an array of Variable objects' do
      expect(subject.variables).to be_an Array
      expect(subject.variables).to all(be_a Script::Variable)
    end
  end
end
