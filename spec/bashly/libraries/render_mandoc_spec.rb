describe 'libraries/render/mandoc' do
  subject do
    RenderContext.new source: source, target: target, show: show
  end

  let(:leeway) { ENV['CI'] ? 10 : 0 }

  let(:source) { 'lib/bashly/libraries/render/mandoc' }
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
      it 'saves a markdown and a manpage for the root command' do
        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/mandoc/render-1')

        expect(File.read "#{target}/download.md")
          .to match_approval('libraries/render/mandoc/render-1-download.md')
          .except(/\w{3,9} 202\d/, 'MONTH YEAR')

        expect(`man "#{target}/download.1" | col -bx | sed '$d'`)
          .to match_approval('libraries/render/mandoc/render-1-download.1')
          .diff(leeway)
      end
    end

    context 'with a config that has commands' do
      let(:config_name) { 'bashly' }

      it 'saves a markdown and man files for each command' do
        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/mandoc/render-2')

        expect(File.read "#{target}/cli-download.md")
          .to match_approval('libraries/render/mandoc/render-2-download.md')
          .except(/\w{3,9} 202\d/, 'MONTH YEAR')

        expect(File).to exist("#{target}/cli.1")
        expect(File).to exist("#{target}/cli-upload.1")
        expect(File).to exist("#{target}/cli-download.1")
      end
    end

    context 'when show is set to a valid file' do
      let(:show) { 'cli.1' }

      before { File.write "#{target}/#{show}", 'dummy' }

      it 'shows the requested file using man' do
        expect(subject).to receive(:system).with(/pandoc.*/).ordered.and_return(true)
        expect(subject).to receive(:system).with("man #{target}/#{show}").ordered

        expect { subject.instance_eval render_script }
          .to output_approval('libraries/render/mandoc/show')
      end
    end
  end
end
