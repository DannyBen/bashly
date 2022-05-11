require 'spec_helper'

describe Libraries::CompletionsFunction do
  subject { described_class.new *args }
  let(:args) { nil }
  before { reset_tmp_dir example: 'minimal'}

  describe '#files' do
    it "returns an array with a single hash" do
      expect(subject.files.to_yaml).to match_approval('libraries/completions_function/files')
    end

    context "with an argument" do
      let(:args) { ["my_function"] }

      it "uses the first argument in the filename of [:path]" do
        expect(subject.files.first[:path]).to eq "#{Settings.source_dir}/lib/#{args.first}.sh"
      end

      it "uses the first argument as the function of [:content]" do
        expect(subject.files.first[:content]).to include "my_function()"
        expect(subject.files.first[:content]).to include "[@bashly-upgrade completions my_function]"
      end
    end
  end

  describe '#post_install_message' do
    it "returns a message" do
      expect(subject.post_install_message).to match_approval('libraries/completions_function/message')
    end
  end
end
