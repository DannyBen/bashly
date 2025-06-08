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

    context 'with private subcommands' do
      let(:fixture) { :exposed_private }

      it 'sets the visibility to :private' do
        expect(subject.command_help_data.to_yaml)
          .to match_approval('script/command/private_exposed_commands')
      end

      context 'when Settings.private_reveal_key is set' do
        before { Settings.private_reveal_key = 'PRIVATE' }
        after { Settings.private_reveal_key = nil }

        it 'sets the visibility to :semi_private' do
          expect(subject.command_help_data.to_yaml)
            .to match_approval('script/command/semi_private_exposed_commands')
        end
      end
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

  describe '#public_command_aliases' do
    let(:fixture) { :private_commands }

    it 'returns an array of command aliases of public subcommands' do
      expect(subject.public_command_aliases).to eq %w[connect c]
    end
  end

  describe '#visible_commands' do
    let(:fixture) { :private_commands }

    it 'returns public commands only (same as #public_commands)' do
      expect(subject.visible_commands.size).to eq 1
      expect(subject.visible_commands.first.name).to eq 'connect'
    end

    context 'when Settings.private_reveal_key is set' do
      before { Settings.private_reveal_key = 'SHOW' }
      after { Settings.private_reveal_key = nil }

      it 'returns all commands (same as #commands)' do
        expect(subject.visible_commands.size).to eq 3
        expect(subject.visible_commands[1].name).to eq 'connect-ftp'
      end
    end
  end

  describe '#visible_command_aliases' do
    let(:fixture) { :private_commands }

    it 'returns an array of command aliases of public subcommands' do
      expect(subject.visible_command_aliases).to eq %w[connect c]
    end

    context 'when Settings.private_reveal_key is set' do
      before { Settings.private_reveal_key = 'SHOW' }
      after { Settings.private_reveal_key = nil }

      it 'returns an array of command aliases of all subcommands' do
        expect(subject.visible_command_aliases).to eq %w[
          connect c connect-ftp cf connect-ssh cs
        ]
      end
    end
  end
end
