require 'spec_helper'

describe Commands::Preview do
  let(:source_dir) { Settings.source_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[preview --help] }.to output_fixture('cli/preview/help')
    end
  end

  context "without arguments" do
    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "prints the generated cli script" do
      expect { subject.run %w[preview] }.to output_fixture('cli/preview/no-args')
        .except(/env bash\n.*\nrun "\$@"/m, "env bash\n...\nrun \"\$@\"")
    end
  end

end
