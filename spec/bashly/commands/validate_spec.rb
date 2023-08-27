describe Commands::Validate do
  subject { described_class.new }

  let(:source_dir) { Settings.source_dir }

  describe 'validate --help' do
    it 'shows long usage' do
      expect { subject.execute %w[validate --help] }.to output_approval('cli/validate/help')
    end
  end

  describe 'validate' do
    before do
      reset_tmp_dir create_src: true
      cp 'lib/bashly/templates/bashly.yml', "#{source_dir}/bashly.yml"
    end

    it 'validates the script' do
      expect { subject.execute %w[validate] }.to output("OK\n").to_stdout
    end
  end

  describe 'validate --verbose' do
    before do
      reset_tmp_dir create_src: true
      cp 'spec/fixtures/workspaces/import/*'
    end

    it 'shows the compiled config file prior to validation' do
      expect { subject.execute %w[validate -v] }.to output_approval('cli/validate/verbose-valid')
    end

    context 'when the compiled config is invalid' do
      before do
        reset_tmp_dir create_src: true
        cp 'spec/fixtures/invalid.yml', "#{source_dir}/bashly.yml"
      end

      it 'still shows it prior to validation' do
        expect { subject.execute %w[validate -v] }.to raise_error(ConfigurationError)
          .and output_approval('cli/validate/verbose-invalid')
      end
    end
  end
end
