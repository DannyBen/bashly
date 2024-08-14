describe Script::Introspection::EnvironmentVariables do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#environment_cariables' do
    it 'returns an array of EnvironmentVariable objects' do
      expect(subject.environment_variables).to be_an Array
      expect(subject.environment_variables.first).to be_a Script::EnvironmentVariable
    end
  end

  describe '#required_environment_variables' do
    it 'returns an array of only the required Argument objects' do
      expect(subject.required_environment_variables.size).to eq 1
      expect(subject.required_environment_variables.first.name).to eq 'secret_key'
    end
  end
end
