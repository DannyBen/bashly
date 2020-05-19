require 'spec_helper'

describe Commands::Init do
  let(:src_dir) { Settings.source_dir }
  subject { CLI.runner }

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[init --help] }.to output_approval('cli/init/help')
    end
  end

  context "without arguments" do
    before { reset_tmp_dir }
    let(:config_file) { "#{src_dir}/bashly.yml" }
    let(:template_file) { 'lib/bashly/templates/bashly.yml' }
    let(:template) { File.read template_file }

    it "creates a new workspace" do
      expect{ subject.run %w[init] }.to output_approval('cli/init/no-args')
      expect(File).to exist(config_file)
      expect(File.read config_file).to eq template
    end

    context "when the directory exists and not empty" do
      before { system "mkdir -p #{src_dir} && touch #{src_dir}/somefile" }

      it "raises an error" do
        expect{ subject.run %w[init] }.to raise_error(InitError, /not empty/)
      end
    end
  end

  context "with --minimal" do
    before { reset_tmp_dir }
    let(:config_file) { "#{src_dir}/bashly.yml" }
    let(:template_file) { 'lib/bashly/templates/minimal.yml' }
    let(:template) { File.read template_file }

    it "creates a new workspace using the minimal config" do
      expect{ subject.run %w[init --minimal] }.to output_approval('cli/init/minimal')
      expect(File).to exist(config_file)
      expect(File.read config_file).to eq template
    end
  end

end
