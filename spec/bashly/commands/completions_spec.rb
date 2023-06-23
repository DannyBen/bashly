require 'spec_helper'

describe Commands::Completions do
  subject { described_class.new }

  let(:leeway) { RUBY_VERSION < '3.2.0' ? 0 : 5 }
  let(:completions_path) { File.expand_path 'lib/bashly/completions/bashly-completions.bash' }
  let(:completions_script) { File.read completions_path }
  let :mock_installer do
    instance_double Completely::Installer,
      install:                  true,
      uninstall:                true,
      target_path:              'some-target-path',
      script_path:              'some-script-path',
      install_command_string:   'cp source target',
      uninstall_command_string: 'rm -f some files'
  end

  describe '#installer' do
    it 'returns a properly configured Completely::Installer instance' do
      expect(subject.installer).to be_a Completely::Installer
      expect(subject.installer.program).to eq 'bashly'
      expect(subject.installer.script_path).to end_with '/bashly-completions.bash'
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[completions --help] }
        .to output_approval('cli/completions/help')
    end
  end

  context 'without arguments' do
    it 'shows the completions script' do
      expect { subject.execute %w[completions] }
        .to output(completions_script).to_stdout
    end
  end

  context 'with --install' do
    it 'installs the completions script to the completions directory' do
      allow(subject).to receive(:installer).and_return mock_installer

      expect { subject.execute %w[completions --install] }
        .to output_approval('cli/completions/install')
    end

    context 'when the installer fails' do
      it 'raises an error' do
        allow(subject).to receive(:installer).and_return mock_installer
        allow(mock_installer).to receive(:install).and_return(false)

        expect { subject.execute %w[completions --install] }
          .to raise_approval('cli/completions/install-error')
          .diff(leeway)
      end
    end
  end

  context 'with --uninstall' do
    it 'uninstalls the completions script from all completions directories' do
      allow(subject).to receive(:installer).and_return mock_installer

      expect { subject.execute %w[completions --uninstall] }
        .to output_approval('cli/completions/uninstall')
    end

    context 'when the installer fails' do
      it 'raises an error' do
        allow(subject).to receive(:installer).and_return mock_installer
        allow(mock_installer).to receive(:uninstall).and_return(false)

        expect { subject.execute %w[completions --uninstall] }
          .to raise_approval('cli/completions/uninstall-error')
          .diff(leeway)
      end
    end
  end
end
