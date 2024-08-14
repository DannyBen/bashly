describe Script::Introspection::EnvironmentVariables do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :environment_variable_enthusiast }

  describe '#default_environment_variables' do
    it 'returns an array of all the Environment Variables with default values' do
      expect(subject.default_environment_variables.size).to eq 1
      expect(subject.default_environment_variables.first.name).to eq 'file'
    end
  end

  describe '#environment_variables' do
    it 'returns an array of EnvironmentVariable objects' do
      expect(subject.environment_variables).to be_an Array
      expect(subject.environment_variables).to all(be_a Script::EnvironmentVariable)
    end
  end

  describe '#public_environment_variables' do
    it 'returns only environment variables that are not private' do
      expect(subject.public_environment_variables.size).to eq 4
      expect(subject.public_environment_variables.map(&:name)).not_to include 'secret'
    end
  end

  describe '#required_environment_variables' do
    it 'returns an array of only the required Argument objects' do
      expect(subject.required_environment_variables.size).to eq 1
      expect(subject.required_environment_variables.first.name).to eq 'username'
    end
  end

  describe '#validated_environment_variables' do
    it 'returns an array of all the environment variables with a validation' do
      expect(subject.validated_environment_variables.size).to eq 1
      expect(subject.validated_environment_variables.first.name).to eq 'config_dir'
    end
  end

  describe '#whitelisted_environment_variables' do
    it 'returns an array of all the environment_variables with a whitelist arg' do
      expect(subject.whitelisted_environment_variables.size).to eq 1
      expect(subject.whitelisted_environment_variables.first.name).to eq 'protocol'
    end
  end
end
