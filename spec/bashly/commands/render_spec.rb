describe Commands::Render do
  subject { described_class.new }

  let(:source_dir) { Settings.source_dir }
  let(:target) { 'spec/tmp' }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[render --help] }.to output_approval('cli/render/help')
    end
  end

  context 'with :markdown source' do
    before { reset_tmp_dir init: true }

    it 'outputs markdown files' do
      expect { subject.execute %W[render :markdown #{target}] }
        .to output_approval('cli/render/markdown')
    end
  end

  context 'with path source' do
    before { reset_tmp_dir init: true }

    it 'outputs markdown files' do
      expect { subject.execute %W[render lib/bashly/views-alt/markdown #{target}] }
        .to output_approval('cli/render/markdown')
    end
  end

  context 'with an invalid source' do
    it 'raises an error' do
      expect { subject.execute %W[render no-templates-4U #{target}] }
        .to raise_approval('cli/render/source-not-found')
    end
  end

  context 'with --watch' do
    before { reset_tmp_dir init: true }

    let(:bashly_config_path) { "#{source_dir}/bashly.yml" }
    let(:bashly_config) { YAML.load_file bashly_config_path }
    let(:watcher_double) { instance_double Filewatcher, watch: nil }

    it 'generates immediately and on change' do
      allow(Filewatcher).to receive(:new).and_return(watcher_double)
      allow(watcher_double).to receive(:watch).and_yield

      expect { subject.execute %W[render :markdown #{target} --watch] }
        .to output_approval('cli/render/watch')
    end

    context 'when ConfigurationError is raised during watch' do
      let(:watcher_double) { instance_double Filewatcher, watch: nil }

      it 'shows the error gracefully and continues to watch' do
        allow(Filewatcher).to receive(:new).and_return(watcher_double)
        allow(watcher_double).to receive(:watch) do |&block|
          bashly_config['invalid_option'] = 'error this'
          File.write bashly_config_path, bashly_config.to_yaml
          block.call
        end

        expect { subject.execute %W[render :markdown #{target} --watch] }
          .to output_approval('cli/render/watch-stderr').to_stderr
      end
    end
  end
end
