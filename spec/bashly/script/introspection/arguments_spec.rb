describe Script::Introspection::Arguments do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#args' do
    it 'returns an array of Argument objects' do
      expect(subject.args).to be_an Array
      expect(subject.args.first).to be_a Script::Argument
    end
  end

  describe '#default_args' do
    let(:fixture) { :default_values }

    it 'returns an array of only the Argument objects that have default' do
      expect(subject.default_args.size).to eq 1
      expect(subject.default_args.first.name).to eq 'files'
    end
  end

  describe '#repeatable_arg_exist?' do
    context 'when the command does not have any repeatable flags' do
      it 'returns false' do
        expect(subject.repeatable_arg_exist?).to be false
      end
    end

    context 'when the command has at least one repeatable flag' do
      let(:fixture) { :repeatable_arg }

      it 'returns true' do
        expect(subject.repeatable_arg_exist?).to be true
      end
    end
  end

  describe '#required_args' do
    it 'returns an array of only the required Argument objects' do
      expect(subject.required_args.size).to eq 1
      expect(subject.required_args.first.name).to eq 'source'
    end
  end

  describe '#whitelisted_args' do
    let(:fixture) { :whitelist }

    it 'returns an array of args that have a whitelist' do
      expect(subject.whitelisted_args.size).to eq 1
      expect(subject.whitelisted_args.first.name).to eq 'region'
    end
  end
end
