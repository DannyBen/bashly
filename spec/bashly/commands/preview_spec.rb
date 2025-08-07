describe Commands::Preview do
  subject { described_class.new }

  let(:source_dir) { Settings.source_dir }

  describe 'preview --help' do
    it 'shows long usage' do
      expect { subject.execute %w[preview --help] }.to output_approval('cli/preview/help')
    end
  end

  describe 'preview' do
    before do
      reset_tmp_dir create_src: true
      cp 'lib/bashly/templates/bashly.yml', "#{source_dir}/bashly.yml"
    end

    it 'prints the generated cli script' do
      expect { subject.execute %w[preview] }.to output_approval('cli/preview/no-args')
        .except(/env bash\n.*\n\s*fi\n/m, "env bash\n...\nfi\b")
    end
  end
end


