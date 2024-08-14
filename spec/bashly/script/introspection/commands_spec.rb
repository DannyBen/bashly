describe Script::Introspection::Commands do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#command_aliases' do
    let(:fixture) { :aliases }

    it 'returns an array of command aliases' do
      expect(subject.command_aliases).to eq %w[download d pull upload u push update upgrade]
    end
  end

  describe '#command_help_data' do
    let(:fixture) { :exposed }

    it 'returns a hash suitable for showing command and exposed subcommand help' do
      expect(subject.command_help_data.to_yaml)
        .to match_approval('script/command/exposed_commands')
    end
  end

  describe '#command_names' do
    let(:fixture) { :docker }

    it 'returns an array of command names' do
      expect(subject.command_names).to eq %w[container image]
    end
  end

  describe '#commands' do
    let(:fixture) { :docker }

    it 'returns an array of Command objects' do
      expect(subject.commands).to be_an Array
      expect(subject.commands.first).to be_a described_class
    end

    it 'sets the parents property of its commands' do
      expect(subject.commands.first.parents).to eq ['docker']
    end
  end

  describe '#deep_commands' do
    let(:fixture) { :docker }

    it 'returns an array of all commands in the tree' do
      expect(subject.deep_commands.map(&:full_name))
        .to eq ['docker container', 'docker container run', 'docker container stop', 'docker image']
    end

    context 'when include_self is true' do
      it 'prepends the result with the command itself' do
        expect(subject.deep_commands(include_self: true).map(&:full_name))
          .to eq ['docker', 'docker container', 'docker container run', 'docker container stop', 'docker image']
      end
    end
  end

  describe '#default_command' do
    let(:fixture) { :default_command }

    it 'returns a Command object of the first default command' do
      expect(subject.default_command).to be_a described_class
      expect(subject.default_command.name).to eq 'get'
    end
  end

  describe '#grouped_commands' do
    let(:fixture) { :exposed }

    it 'returns a hash with an array of Command objects per group key' do
      expect(subject.grouped_commands.keys).to contain_exactly('Cluster Commands:', 'Commands:')
      expect(subject.grouped_commands['Commands:'].count).to eq 4
      expect(subject.grouped_commands['Commands:']).to all(be_a described_class)
    end
  end

  describe '#public_commands' do
    let(:fixture) { :private_commands }

    it 'returns an array of Command objects excluding private commands' do
      expect(subject.public_commands.count).to eq 1
      expect(subject.public_commands.first.name).to eq 'connect'
    end
  end

  describe '#public_commands_aliases' do
    let(:fixture) { :private_commands }

    it 'returns an array of command aliases of public subcommands' do
      expect(subject.public_command_aliases).to eq %w[connect c]
    end
  end
end
