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
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    it "validates the script" do
      expect { subject.run %w[validate] }.to output("OK\n").to_stdout
    end
  end

  # DEPRECATION 0.8.0
  context "with deprecated command.short option" do
    before do
      reset_tmp_dir create_src: true
      cp "spec/fixtures/deprecations/command-short.yml", "#{source_dir}/bashly.yml"
    end

    it "shows deprecations count in stdout" do
      expect { subject.run %w[validate] }.to output_approval('cli/validate/deprecation-command-short')
    end

    it "shows deprecations messages in stderr" do
      expect { subject.run %w[validate] }.to output_approval('cli/deprecations/command-short-stderr').to_stderr
    end
  end
end
