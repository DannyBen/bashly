describe Commands::Render do
  subject { described_class.new }

  let(:ruby_leeway) { RUBY_VERSION < '3.2.0' ? 0 : 5 }
  let(:markdown_leeway) { ENV['CI'] ? 20 : 0 }
  let(:source_dir) { Settings.source_dir }
  let(:target) { 'spec/tmp' }

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[render --help] }.to output_approval('cli/render/help')
    end
  end

  context 'with --list' do
    it 'shows the list of internal render sources' do
      expect { subject.execute %w[render --list] }
        .to output_approval('cli/render/list')
    end
  end

  context 'with --about' do
    it 'shows the readme of the template source' do
      expect { subject.execute %w[render :markdown --about] }
        .to output_approval('cli/render/about-markdown').diff(markdown_leeway)
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
      expect { subject.execute %W[render lib/bashly/libraries/render/markdown #{target}] }
        .to output_approval('cli/render/markdown')
    end
  end

  context 'with an invalid source' do
    it 'raises an error' do
      expect { subject.execute %W[render no-templates-4U #{target}] }
        .to raise_approval('cli/render/source-not-found')
        .diff(ruby_leeway)
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
  end
end
