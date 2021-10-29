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
        File.write "#{source_dir}/download_command.sh", "some new user content"
      end

      it "does not overwrite them" do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/no-args-skip')
        expect(File.read "#{source_dir}/download_command.sh").to eq "some new user content"
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
      expect { subject.run %w[generate --quiet] }.to_not output.to_stdout
      expect(File).to exist(cli_script)
    end
  end

  context "with --wrap function" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir
      success = system "mkdir -p #{source_dir} && cp lib/bashly/templates/bashly.yml #{source_dir}/bashly.yml"
      expect(success).to be true
    end

    it "generates the cli script wrapped in a function without bash3 bouncer" do
      expect { subject.run %w[generate -w function] }.to output_approval('cli/generate/wrap-function')
      expect(File).to exist(cli_script)
      lines = File.readlines cli_script
      expect(lines[0..10].join).to match_approval('cli/generate/wrap-script')
    end
  end
  
  context "with --upgrade" do
    let(:lib_files) { Dir["spec/tmp/src/lib/**/*.sh"].sort }
    let(:outdated_text) { "OUTDATED TEXT" }

    before do
      reset_tmp_dir copy_from: 'spec/fixtures/workspaces/lib-upgrade'
    end

    it "claims to upgrade all upgradable libraries" do
      expect { subject.run %w[generate -u] }.to output_approval('cli/generate/upgrade')
    end

    it "actually upgrades all upgradable libraries" do
      lib_files.each do |file|
        File.append file, outdated_text
      end

      expect { subject.run %w[generate -u] }.to output_approval('cli/generate/upgrade')

      lib_files.each do |file|
        expect(File.read file).to_not include(outdated_text),
          "Expected to not find #{outdated_text} in #{file}, but found it"
      end
    end

    context "when the magic comment does not exist in the target file" do
      let(:selective_lib_files) { lib_files[0..-2] }

      before do
        selective_lib_files.each do |file|
          File.write file, File.read(file).gsub("[@bashly-upgrade", "[@please-dont")
        end
      end

      it "avoids upgrading it" do
        expect { subject.run %w[generate -u] }.to output_approval('cli/generate/dont-upgrade')

        selective_lib_files.each do |file|
          expect(File.read file).to include("@please-dont"),
            "Expected to find @please-dont in #{file}, but didn't"
        end
      end
    end

    context "when the upgrade candidate has a different path than the library's" do
      let(:file) { lib_files[0] }
      let(:custom_text) { "CUSTOM TEXT" }
      let(:alt_filename) { file.gsub /([a-z])\.sh/, '\1-b.sh' }

      before do
        File.append file, custom_text
        expect(system "mv #{file} #{alt_filename}").to be true
      end

      it "avoids upgrading it and shows a warning" do
        expect { subject.run %w[generate -u] }.to output_approval('cli/generate/upgrade-path-mismatch')

        expect(File.read alt_filename).to include(custom_text),
          "Expected to find #{custom_text} in #{file}, but didn't"
      end
    end

  end
end
