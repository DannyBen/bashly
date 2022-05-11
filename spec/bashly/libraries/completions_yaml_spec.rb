require 'spec_helper'

describe Libraries::CompletionsYAML do
  subject { described_class.new *args }
  let(:args) { nil }
  before { reset_tmp_dir example: 'minimal'}

  describe '#files' do
    it "returns an array with a single hash" do
      expect(subject.files.to_yaml).to match_approval('libraries/completions_yaml/files')
    end

    context "with an argument" do
      let(:args) { ["filename.yml"] }

      it "uses the first argument as a filename" do
        expect(subject.files.first[:path]).to eq args.first
      end
    end
  end

  describe '#post_install_message' do
    it "returns a message" do
      expect(subject.post_install_message).to match_approval('libraries/completions_yaml/message')
    end
  end
end
