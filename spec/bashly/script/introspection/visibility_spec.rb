describe Script::Introspection::Visibility do
  subject do
    result = Script::Command.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :private_commands }

  describe '#visibility' do
    it 'returns :public for public commands and :private for private ones' do
      expect(subject.visibility).to eq :public
      expect(subject.commands[1].visibility).to eq :private
    end

    context 'when Settings.private_reveal_key is set' do
      before { Settings.private_reveal_key = 'PRIVATE' }
      after { Settings.private_reveal_key = nil }

      it 'returns :semi_private for private commands' do
        expect(subject.commands[1].visibility).to eq :semi_private
      end
    end
  end
end
