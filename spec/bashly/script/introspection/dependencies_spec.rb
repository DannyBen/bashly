describe Script::Introspection::Dependencies do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#dependencies' do
    let(:fixture) { :dependencies }

    it 'returns an array of Dependency objects' do
      expect(subject.dependencies).to be_an Array
      expect(subject.dependencies.first).to be_a Script::Dependency
    end
  end
end
