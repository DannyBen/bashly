require 'spec_helper'

describe Script::Flag do
  fixtures = load_fixture('script/flags')

  let(:fixture) { :basic_flag }
  let(:command) { "some command"}
  
  subject { described_class.new fixtures[fixture] }

  describe '#completion_data' do
    context "when the flag has allowed defined" do
      let(:fixture) { :completions_allowed }

      it "returns a data structure for completely with the allowed list" do
        expect(subject.completion_data(command).to_yaml).to match_approval("completions/flag-allowed")
      end
    end

    context "when the flag has completions defined" do
      let(:fixture) { :completions_completions }

      it "returns a data structure for completely with the completions list" do
        expect(subject.completion_data(command).to_yaml).to match_approval("completions/flag-completions")
      end
    end

    context "when the flag does not have allowed or completions" do
      it "returns an empty hash" do
        expect(subject.completion_data(command)).to eq({})
      end
    end
  end
end
