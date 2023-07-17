describe Commands::Doc do
  subject { described_class.new }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[doc --help] }.to output_approval('cli/doc/help')
    end
  end

  context 'without arguments' do
    it 'shows all the help data' do
      expect { subject.execute %w[doc] }.to output_approval('cli/doc/full')
    end
  end

  context 'with --index' do
    it 'shows only the help keys' do
      expect { subject.execute %w[doc --index] }.to output_approval('cli/doc/index')
    end
  end

  context 'with a search string' do
    context 'when there is an exact match' do
      it 'only shows this topic' do
        expect { subject.execute %w[doc environment_variable] }.to output_approval('cli/doc/env_Var')
      end
    end

    context 'when there is no exact match and --index is provided' do
      it 'only shows all keys containing it' do
        expect { subject.execute %w[doc private -i] }.to output_approval('cli/doc/private')
      end
    end

    context 'when there is no match' do
      it 'raises an error' do
        expect { subject.execute %w[doc deploy] }.to raise_exception(Error, 'No match')
      end
    end
  end
end
