# This spec tests that the rendering using the libraries/render templates
# is generating the expected output.
describe 'rendering markdown' do
  subject { Commands::Render.new }

  let(:source_dir) { Settings.source_dir }

  target = 'spec/tmp'
  examples = %w[
    catch-all-advanced
    dependencies-alt
    docker-like
    extensible-delegate
    minimal
    render-markdown
  ]

  # Allow up to a certain string distance from the approval text in CI
  leeway = ENV['CI'] ? 20 : 0

  examples.each do |example|
    describe example do
      before do
        reset_tmp_dir create_src: true
        cp "examples/#{example}/src/bashly.yml", "#{source_dir}/bashly.yml"
      end

      it 'renders properly' do
        expect { subject.execute %W[render :markdown #{target}] }
          .to output_approval("rendering/markdown/#{example}/stdout")

        Dir["#{target}/*.md"].each do |file|
          puts "    => #{file}"
          basename = File.basename file
          expect(File.read file).to match_approval("rendering/markdown/#{example}/#{basename}")
            .diff(leeway)
        end
      end
    end
  end
end
