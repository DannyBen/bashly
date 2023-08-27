describe 'libraries/render/markdown' do
  subject do
    RenderContext.new source: source, target: target, show: show
  end

  let(:source) { 'lib/bashly/libraries/render/markdown' }
  let(:target) { 'spec/tmp' }
  let(:show) { nil }
  let(:config) { Bashly::Config.new "lib/bashly/templates/#{config_name}.yml" }
  let(:config_name) { 'minimal' }

  let(:render_script) { File.read "#{source}/render.rb" }

  before do
    subject.config = config
    reset_tmp_dir
  end

  describe '#render' do
    context 'with a config that does not have commands' do
      it 'saves a single file named index.md' do
        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/markdown/render-1')

        expect(File.read "#{target}/index.md")
          .to match_approval('libraries/render/markdown/render-1-index.md')
      end
    end

    context 'with a config that has commands' do
      let(:config_name) { 'bashly' }

      it 'saves a index.md and a file for each command' do
        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/markdown/render-2')

        expect(File.read "#{target}/index.md")
          .to match_approval('libraries/render/markdown/render-2-index.md')

        expect(File.read "#{target}/cli download.md")
          .to match_approval('libraries/render/markdown/render-2-download.md')
      end
    end

    context 'when show is set to a valid file' do
      let(:show) { 'index.md' }

      it 'shows the requested file using TTY::Markdown' do
        expect(TTY::Markdown).to receive(:parse_file).with("#{target}/#{show}")

        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/markdown/show')
      end
    end
  end
end
