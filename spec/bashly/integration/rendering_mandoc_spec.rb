# This spec tests that the rendering using the libraries/render templates
# is generating the expected output.
describe 'rendering mandoc' do
  subject { Commands::Render.new }

  target = 'spec/tmp'
  examples = %w[
    catch-all-advanced
    dependencies-alt
    docker-like
    extensible-delegate
    minimal
  ]

  # Allow up to a certain string distance from the approval text in CI
  leeway = ENV['CI'] ? 20 : 0

  examples.each do |example|
    describe example do
      before do
        Settings.config_path = "examples/#{example}/src/bashly.yml"
        reset_tmp_dir
      end

      it 'renders properly' do
        expect { subject.execute %W[render :mandoc #{target}] }
          .to output_approval("rendering/mandoc/#{example}/stdout")

        Dir["#{target}/*.md"].each do |file|
          puts "    => #{file}"
          basename = File.basename file
          expect(File.read file).to match_approval("rendering/mandoc/#{example}/#{basename}")
            .diff(leeway)

          expect(File).to exist("#{target}/#{File.basename(file, '.md')}.1")
        end
      end
    end
  end
end
