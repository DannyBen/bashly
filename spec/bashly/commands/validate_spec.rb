require 'spec_helper'

describe Commands::Validate do
  let(:source_dir) { Settings.source_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[validate --help] }.to output_approval('cli/validate/help')
    end
  end

  context "without arguments" do
    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "validates the script" do
      expect { subject.run %w[validate] }.to output("OK\n").to_stdout
    end
  end

end
