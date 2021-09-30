require 'spec_helper'

describe Commands::Generate do
  let(:source_dir) { Settings.source_dir }
  let(:target_dir) { Settings.target_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[generate --help] }.to output_approval('cli/generate/help')
    end
  end

  context "without arguments" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "generates the cli script" do
      expect { subject.run %w[generate] }.to output_approval('cli/generate/no-args')
      expect(File).to exist(cli_script)
    end

    context "when source files already exist" do
      before do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/no-args')
        File.write "#{source_dir}/cli_get_command.sh", "some new user content"
      end

      it "does not overwrite them" do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/no-args-skip')
        expect(File.read "#{source_dir}/cli_get_command.sh").to eq "some new user content"
      end
    end

    context "with the minimal config" do
      let(:cli_script) { "#{target_dir}/download" }

      before do
        system "cp lib/bashly/templates/minimal.yml #{source_dir}/bashly.yml"
      end

      it "generates the cli script" do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/minimal')
        expect(File).to exist(cli_script)
      end
    end
  end

  context "with --quiet" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "generates the cli script" do
      expect { subject.run %w[generate --quiet] }.to output_approval('cli/generate/quiet')
      expect(File).to exist(cli_script)
    end

    context "when source files already exist" do
      before do
        expect { subject.run %w[generate --quiet] } #.to output_nothing
        File.write "#{source_dir}/download_command.sh", "some new user content"
      end

      it "does not overwrite them" do
        expect { subject.run %w[generate --quiet] } #.to output_nothing
        expect(File.read "#{source_dir}/download_command.sh").to eq "some new user content"
      end
    end

  end

  context "with --wrap function" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "generates the cli script wrapped in a function" do
      expect { subject.run %w[generate -w function] }.to output_approval('cli/generate/wrap-function')
      expect(File).to exist(cli_script)
      lines = File.readlines cli_script
      expect(lines[5]).to eq "function() {\n"
    end
  end

end
