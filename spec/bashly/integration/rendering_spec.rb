# This spec tests that the rendering using `views-alt` templates is generating
# the expected output.
describe 'rendering templates' do
  subject { Commands::Render.new }

  target = 'spec/tmp'
  examples = %w[docker-like minimal]

  # Allow up to a certain string distance from the approval text in CI
  leeway = ENV['CI'] ? 20 : 0

  examples.each do |example|
    describe example do
      before do
        Settings.config_path = "examples/#{example}/src/bashly.yml"
        reset_tmp_dir
      end

      it 'runs properly' do
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
