# This spec tests that the rendering using `views-alt` templates is generating
# the expected output.
describe 'rendering templates' do
  subject { Commands::Render.new }

  target = 'spec/tmp'
  examples = %w[docker-like minimal]

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
        end
      end
    end
  end
end
