describe Script::Introspection::Flags do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#default_flags' do
    let(:fixture) { :default_values }

    it 'returns an array of only the Flags objects that have default' do
      expect(subject.default_flags.size).to eq 1
      expect(subject.default_flags.first.long).to eq '--format'
    end
  end

  describe '#flags' do
    it 'returns an array of Flag objects' do
      expect(subject.flags).to be_an Array
      expect(subject.flags.first).to be_a Script::Flag
    end
  end

  describe '#global_flags?' do
    context 'when a command has flags and commands' do
      let(:fixture) { :mode_global_flags }

      it 'returns true' do
        expect(subject).to be_global_flags
      end
    end

    context 'when a command has flags but no commands' do
      let(:fixture) { :mode_flags }

      it 'returns false' do
        expect(subject).not_to be_global_flags
      end
    end

    context 'when a command has commands but no flags' do
      let(:fixture) { :mode_commands }

      it 'returns false' do
        expect(subject).not_to be_global_flags
      end
    end
  end

  describe '#needy_flags' do
    let(:fixture) { :needy_flags }

    it 'returns an array of only the needy Flag objects' do
      expect(subject.needy_flags.size).to eq 2
      expect(subject.needy_flags.first.long).to eq '--add'
    end
  end

  describe '#public_flags' do
    let(:fixture) { :private_flags }

    it 'returns an array of only the non private Flag objects' do
      expect(subject.public_flags.size).to eq 1
      expect(subject.public_flags.first.long).to eq '--new'
    end
  end

  describe '#required_flags' do
    it 'returns an array of only the required Flag objects' do
      expect(subject.required_flags.size).to eq 1
      expect(subject.required_flags.first.long).to eq '--force'
    end
  end

  describe '#short_flag_exist?' do
    let(:fixture) { :flag_hog }

    context 'when the command has this short flag' do
      it 'returns true' do
        expect(subject.short_flag_exist?('-h')).to be true
      end
    end

    context 'when the command does not have this short flag' do
      it 'returns false' do
        expect(subject.short_flag_exist?('-s')).to be false
      end
    end
  end

  describe '#visible_flags' do
    let(:fixture) { :private_flags }

    it 'returns public flags only (same as #public_flags)' do
      expect(subject.visible_flags.size).to eq 1
      expect(subject.visible_flags.first.long).to eq '--new'
    end

    context 'when Settings.private_reveal_key is set' do
      before { Settings.private_reveal_key = 'SHOW' }
      after { Settings.private_reveal_key = nil }

      it 'returns all flags (same as #flags)' do
        expect(subject.visible_flags.size).to eq 2
        expect(subject.visible_flags.first.long).to eq '--legacy'
      end
    end
  end

  describe '#whitelisted_flags' do
    let(:fixture) { :whitelist }

    it 'returns an array of flags that have a whitelist' do
      expect(subject.whitelisted_flags.size).to eq 1
      expect(subject.whitelisted_flags.first.long).to eq '--user'
    end
  end
end
