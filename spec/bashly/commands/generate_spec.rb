require 'spec_helper'

describe Commands::Generate do
  let(:source_dir) { Settings.source_dir }
  let(:target_dir) { Settings.target_dir }
  let(:cli_script_content) { File.read cli_script }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[generate --help] }.to output_approval('cli/generate/help')
    end
  end

  context "without arguments" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    it "generates the cli script" do
      expect { subject.run %w[generate] }.to output_approval('cli/generate/no-args')
      expect(File).to exist(cli_script)
    end

    context "when BASHLY_ENV=production" do
      before { Settings.env = :production }
      after  { Settings.env = nil }

      it "generates a script without view markers" do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/production-env-var')
        expect(File).to exist(cli_script)
        expect(cli_script_content).to_not include '# :'
      end
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

    context "with 2 levels of nested commands" do
      let(:file) { "#{target_dir}/src/upload_command.sh" }

      before do
        system "cp spec/fixtures/nested.yml #{source_dir}/bashly.yml"
      end

      it "does not generate the file for the middle command" do
        expect { subject.run %w[generate] }.to output_approval('cli/generate/nested')
        expect(File).to_not exist(file)
      end
    end
  end

  context "with --quiet" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    it "generates the cli script" do
      expect { subject.run %w[generate --quiet] }.to_not output.to_stdout
      expect(File).to exist(cli_script)
    end
  end

  context "with --wrap function" do
    let(:cli_script) { "#{target_dir}/cli" }

    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    it "generates the cli script wrapped in a function without bash3 bouncer" do
      expect { subject.run %w[generate --wrap function] }.to output_approval('cli/generate/wrap-function')
      expect(File).to exist(cli_script)
      lines = File.readlines cli_script
      expect(lines[0..10].join).to match_approval('cli/generate/wrap-script').except(/\d+\.\d+\.\d+/)
    end
  end
  
  context "with --env production" do
    let(:cli_script) { "#{target_dir}/cli" }
    let(:cli_script_content) { File.read cli_script }

    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", "#{source_dir}/bashly.yml"
    end

    after  { Settings.env = nil }

    it "generates a script without view markers" do
      expect { subject.run %w[generate --env production] }.to output_approval('cli/generate/production')
      expect(File).to exist(cli_script)
      expect(cli_script_content).to_not include '# :'
    end
  end

  context "with --upgrade" do
    let(:lib_files) { Dir["spec/tmp/src/lib/**/*.sh"].sort }
    let(:outdated_text) { "OUTDATED TEXT" }

    before do
      reset_tmp_dir
      cp 'spec/fixtures/workspaces/lib-upgrade/*'
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

    context "when the upgrade candidate has magic comment with an unknown library" do
      let(:file) { lib_files[0] }
      let(:patched_content) { file_content.gsub "[@bashly-upgrade colors]", "[@bashly-upgrade no-such-lib]" }
      let(:file_content) { File.read file }

      before do
        File.write file, patched_content
      end

      it "shows a warning" do
        expect { subject.run %w[generate -u] }.to output_approval('cli/generate/upgrade-unknown-lib')
      end
    end
  end

  context "with --watch" do
    before do
      reset_tmp_dir create_src: true
      cp "lib/bashly/templates/bashly.yml", bashly_config_path
    end

    let(:bashly_config_path) { "#{source_dir}/bashly.yml" }
    let(:bashly_config) { YAML.load_file bashly_config_path }

    it "generates immediately and on change" do
      expect do
        expect_any_instance_of(Filewatcher).to receive(:watch) do |watcher, &block|
          block.call
        end

        subject.run %W[generate --watch]
      end.to output_approval('cli/generate/watch')
    end

    context "when ConfigurationError is raised during watch" do
      it "shows the error gracefully and continues to watch" do
        expect do
          expect_any_instance_of(Filewatcher).to receive(:watch) do |watcher, &block|
            bashly_config['invalid_option'] = 'error this'
            File.write bashly_config_path, bashly_config.to_yaml
            block.call
          end

          subject.run %W[generate --watch]
        end.to output_approval('cli/generate/watch-stderr').to_stderr
      end
    end
  end

  # DEPRECATION 0.8.0
  context "with deprecated command.short option" do
    before do
      reset_tmp_dir create_src: true
      cp "spec/fixtures/deprecations/command-short.yml", "#{source_dir}/bashly.yml"
    end

    it "shows deprecations messages in stderr" do
      expect { subject.run %w[generate] }.to output_approval('cli/deprecations/command-short-stderr').to_stderr
    end
  end

end
