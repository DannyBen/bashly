require 'spec_helper'

describe Commands::Add do
  let(:source_dir) { Settings.source_dir }
  let(:target_dir) { Settings.target_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[add --help] }.to output_approval('cli/add/help')
    end
  end

  context "without arguments" do
    it "shows long usage" do
      expect{ subject.run %w[add] }.to output_approval('cli/generate/usage')
    end
  end

  context "with colors command" do
    let(:lib_file) { "#{source_dir}/lib/colors.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the colors.sh lib file to the user space" do
      expect { subject.run %w[add colors] }.to output_approval('cli/add/colors')
      expect(File).to exist(lib_file)
    end
  end

  context "with comp command" do
    before do
      reset_tmp_dir create_src: true
      expect { subject.run %w[init] }.to output_approval('cli/add/init')
    end

    context "with yaml subcommand" do
      it "creates completions.yml" do
        expect { subject.run %w[add comp yaml] }.to output_approval('cli/add/comp-yaml')
        expect(File.read "#{target_dir}/completions.yml").to match_approval('cli/add/comp-yaml-file')
      end
    end

    context "with script subcommand" do
      it "creates completions.bash" do
        expect { subject.run %w[add comp script] }.to output_approval('cli/add/comp-script')
        expect(File.read "#{target_dir}/completions.bash").to match_approval('cli/add/comp-script-file')
      end
    end

    context "with function subcommand" do
      it "creates lib/send_completions.sh" do
        expect { subject.run %w[add comp function] }.to output_approval('cli/add/comp-function')
        expect(File.read "#{source_dir}/lib/send_completions.sh").to match_approval('cli/add/comp-function-file')
      end
    end

    context "with an unrecognized subcommand" do
      it "raises an error" do
        expect { subject.run %w[add comp no-such-format] }.to raise_approval('cli/add/comp-error')
      end
    end
  end

  context "with config command" do
    let(:lib_file) { "#{source_dir}/lib/config.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the config.sh lib file to the user space" do
      expect { subject.run %w[add config] }.to output_approval('cli/add/config')
      expect(File).to exist(lib_file)
    end
  end

  context "with lib command" do
    let(:lib_file) { "#{source_dir}/lib/sample_function.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies a sample function to the user space under lib directory" do
      expect { subject.run %w[add lib] }.to output_approval('cli/add/lib')
      expect(File).to exist(lib_file)
    end
  end

  context "with settings command" do
    let(:settings_file) { "#{target_dir}/settings.yml" }
    let(:template_file) { "lib/bashly/templates/settings.yml" }

    before do
      reset_tmp_dir
    end

    it "copies the settings file to the current directory" do
      expect do
        Dir.chdir target_dir do
          subject.run %w[add settings]
        end
      end.to output_approval('cli/add/settings')
      expect(File).to exist(settings_file)
      expect(File.read settings_file).to eq File.read(template_file)
    end

    context "when the file exists" do
      it "skips copying it" do
        expect do
          Dir.chdir target_dir do
            subject.run %w[add settings]
            subject.run %w[add settings]
          end
        end.to output_approval('cli/add/settings-exist')
      end
    end
  end

  context "with strings command" do
    let(:strings_file) { "#{source_dir}/bashly-strings.yml" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the strings configuration to the user space" do
      expect { subject.run %w[add strings] }.to output_approval('cli/add/strings')
      expect(File).to exist(strings_file)
    end

    context "when the source directory does not exist" do
      before do
        reset_tmp_dir
      end

      it "raises an error" do
        expect { subject.run %w[add strings] }.to raise_error(InitError, /does not exist/)
      end
    end

    context "when the file exists" do
      it "skips copying it" do
        expect { subject.run %w[add strings] }.to output_approval('cli/add/strings')
        expect { subject.run %w[add strings] }.to output_approval('cli/add/strings-exist')
      end
    end
  end

  context "with test command" do
    let(:lib_file) { "#{target_dir}/test/approvals.bash" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the test folder to the user space" do
      expect { subject.run %w[add test] }.to output_approval('cli/add/test')
      expect(File).to exist(lib_file)
    end
  end

  context "with validations command" do
    let(:lib_file) { "#{source_dir}/lib/validations/validate_integer.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the validation lib folder to the user space" do
      expect { subject.run %w[add validations] }.to output_approval('cli/add/validations')
      expect(File).to exist(lib_file)
    end
  end

  context "with yaml command" do
    let(:lib_file) { "#{source_dir}/lib/yaml.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the yaml.sh lib file to the user space" do
      expect { subject.run %w[add yaml] }.to output_approval('cli/add/yaml')
      expect(File).to exist(lib_file)
    end
  end

end
