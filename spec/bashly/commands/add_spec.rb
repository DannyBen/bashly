require 'spec_helper'

describe Commands::Add do
  let(:source_dir) { Settings.source_dir }
  let(:target_dir) { Settings.target_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[add --help] }.to output_fixture('cli/add/help')
    end
  end

  context "without arguments" do
    it "shows long usage" do
      expect{ subject.run %w[add] }.to output_fixture('cli/generate/usage')
    end
  end

  context "with strings command" do
    let(:strings_file) { "#{source_dir}/bashly-strings.yml" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the strings configuration to the user space" do
      expect { subject.run %w[add strings] }.to output_fixture('cli/add/strings')
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
        expect { subject.run %w[add strings] }.to output_fixture('cli/add/strings')
        expect { subject.run %w[add strings] }.to output_fixture('cli/add/strings-exist')
      end
    end
  end

  context "with lib command" do
    let(:lib_file) { "#{source_dir}/lib/sample_function.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies a sample function to the user space under lib directory" do
      expect { subject.run %w[add lib] }.to output_fixture('cli/add/lib')
      expect(File).to exist(lib_file)
    end
  end

  context "with config command" do
    let(:lib_file) { "#{source_dir}/lib/config.sh" }

    before do
      reset_tmp_dir create_src: true
    end

    it "copies the config.sh lib file to the user space" do
      expect { subject.run %w[add config] }.to output_fixture('cli/add/config')
      expect(File).to exist(lib_file)
    end
  end


end
