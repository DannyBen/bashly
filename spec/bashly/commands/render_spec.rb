describe Commands::Render do
  subject { described_class.new }

  let(:leeway) { RUBY_VERSION < '3.2.0' ? 0 : 5 }
  let(:source_dir) { Settings.source_dir }
  let(:target) { 'spec/tmp' }
  let(:mock_render_source) { double RenderSource, readme: '# Heading' }

  describe 'render --help' do
    it 'shows long usage' do
      expect { subject.execute %w[render --help] }.to output_approval('cli/render/help')
    end
  end

  describe 'render --list' do
    it 'shows the list of internal render sources' do
      expect { subject.execute %w[render --list] }
        .to output_approval('cli/render/list')
    end
  end

  describe 'render SOURCE --about' do
    it 'shows the readme of the RenderSource' do
      allow(subject).to receive(:render_source).and_return(mock_render_source)

      expect { subject.execute %w[render :markdown --about] }
        .to output_approval('cli/render/about-markdown')
    end
  end

  describe 'render SOURCE TARGET' do
    it 'call RenderSource#render' do
      allow(subject).to receive(:render_source).and_return(mock_render_source)
      expect(mock_render_source).to receive(:render).with(target, show: nil)

      subject.execute %W[render :markdown #{target}]
    end
  end

  describe 'render SOURCE TARGET - when SOURCE starts with a colon' do
    let(:mock_render_source) { RenderSource.new :markdown }

    it 'passes it as a symbol to RenderSource' do
      allow(RenderSource).to receive(:new).with(:markdown).and_return(mock_render_source)
      expect(mock_render_source).to receive(:render)

      subject.execute %W[render :markdown #{target}]
    end
  end

  describe 'render SOURCE TARGET - when SOURCE is invalid' do
    it 'raises an error' do
      expect { subject.execute %W[render no-templates-4U #{target}] }
        .to raise_approval('cli/render/source-not-found')
        .diff(leeway)
    end
  end

  describe 'SOURCE TARGET --show PATH' do
    it 'passes show: true to RenderSource#render' do
      allow(subject).to receive(:render_source).and_return(mock_render_source)
      expect(mock_render_source).to receive(:render).with(target, show: 'index.md')

      subject.execute %W[render :markdown #{target} --show index.md]
    end
  end

  describe 'SOURCE TARGET --watch' do
    let(:bashly_config_path) { "#{source_dir}/bashly.yml" }
    let(:bashly_config) { YAML.load_file bashly_config_path }
    let(:watcher_double) { instance_double Filewatcher, watch: nil }

    it 'generates immediately and on change' do
      allow(Filewatcher).to receive(:new).and_return(watcher_double)
      allow(watcher_double).to receive(:watch).and_yield

      expect(subject).to receive(:render).twice

      expect { subject.execute %W[render :markdown #{target} --watch] }
        .to output_approval('cli/render/watch')
    end
  end
end
