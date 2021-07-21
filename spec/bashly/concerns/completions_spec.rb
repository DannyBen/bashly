require 'spec_helper'

describe Models::Command do
  let(:fixture) { :completions_simple }

  subject do
    options = load_fixture('models/commands')[fixture]
    described_class.new options
  end

  describe '#completion_data' do
    it "returns a data structure for completely" do
      expect(subject.completion_data.to_yaml).to match_approval("completions/simple")
    end
  end

  describe '#completion_function' do
    it "returns a bash completion script wrapped in a function" do
      expect(subject.completion_function "custom_name")
        .to match_approval("completions/function")
    end
  end

  context "with a more complex command" do
    let(:fixture) { :completions_advanced }

    describe '#completion_data' do
      it "returns a data structure for completely" do
        expect(subject.completion_data.to_yaml)
          .to match_approval("completions/advanced")
      end
    end

    describe '#completion_script' do
      it "returns a bash completion script" do
        expect(subject.completion_script)
          .to match_approval("completions/script")
      end
    end
  end
end
