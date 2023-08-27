describe Commands::Shell do
  subject { described_class.new }

  describe 'shell --help' do
    it 'shows long usage' do
      expect { subject.execute %w[shell --help] }.to output_approval('cli/shell/help')
    end
  end

  describe 'shell' do
    let(:terminal_double) { instance_double MisterBin::Terminal, start: nil, on: nil }

    it 'runs MisterBin::Terminal' do
      allow(MisterBin::Terminal).to receive(:new).and_return(terminal_double)
      expect(terminal_double).to receive(:start)
      subject.execute %w[shell]
    end
  end

  describe 'in-terminal commands' do
    before do
      ENV['BASHLY_SHELL'] = nil
      allow(Readline).to receive(:readline).and_return(*input)
    end

    context 'with exit command' do
      let(:input) { ['exit'] }

      it 'starts a terminal and shows CLI usage' do
        expect { subject.execute %w[shell] }.to output_approval 'cli/shell/boot'
      end
    end
  end
end
