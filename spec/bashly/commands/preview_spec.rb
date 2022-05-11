require 'spec_helper'

describe Commands::Preview do
  let(:source_dir) { Settings.source_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[preview --help] }.to output_approval('cli/preview/help')
    end
  end

  context "without arguments" do
    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    it "prints the generated cli script" do
      expect { subject.run %w[preview] }.to output_approval('cli/preview/no-args')
        .except(/env bash\n.*\nrun "\$@"/m, "env bash\n...\nrun \"\$@\"")
    end
  end

  # DEPRECATION 0.8.0
  context "with deprecated command.short option" do
    before do
      reset_tmp_dir create_src: true
      cp "spec/fixtures/deprecations/command-short.yml", "#{source_dir}/bashly.yml"
    end

    it "shows deprecations messages in stderr" do
      expect { subject.run %w[preview] }.to output_approval('cli/deprecations/command-short-stderr').to_stderr
    end
  end

end
