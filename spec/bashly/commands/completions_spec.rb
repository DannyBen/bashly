require 'spec_helper'

describe Commands::Completions do
  subject { described_class.new }

  let(:completions_path) { File.expand_path 'lib/bashly/completions/bashly-completions.bash' }
  let(:completions_script) { File.read completions_path }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[completions --help] }.to output_approval('cli/completions/help')
    end
  end

  context 'without arguments' do
    it 'shows the completions script' do
      expect { subject.execute %w[completions] }.to output(completions_script).to_stdout
    end
  end

  context 'with --install' do
    it 'installs the completions script to the completions directory' do
      allow(subject).to receive(:compdir_candidates).and_return ['/tmp']
      expect(subject).to receive(:system).with(%Q[sudo cp "#{completions_path}" "/tmp/bashly"])
      expect { subject.execute %w[completions --install] }.to output_approval('cli/completions/install')
    end

    context 'when the completions directory is not found' do
      it 'raises an error' do
        allow(Dir).to receive(:exist?).twice.and_return(false)
        expect { subject.execute %w[completions --install] }.to raise_approval('cli/completions/install-error')
      end
    end

    context 'when running as root' do
      it 'installs the completions script to the completions directory without sudo' do
        allow(subject).to receive(:compdir_candidates).and_return ['/tmp']
        allow(subject).to receive(:root_user?).and_return true
        expect(subject).to receive(:system).with(%Q[cp "#{completions_path}" "/tmp/bashly"])
        expect { subject.execute %w[completions --install] }.to output_approval('cli/completions/install-root')
      end
    end
  end
end
