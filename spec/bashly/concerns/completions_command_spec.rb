require 'spec_helper'

describe Script::Command do
  fixtures = load_fixture('script/commands')

  let(:fixture) { :completions_simple }
  subject { described_class.new fixtures[fixture] }

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

  context "with a command that uses whitelist args" do
    let(:fixture) { :completions_whitelist }

    describe '#completion_data' do
      it "returns a data structure that includes thw whitelist" do
        expect(subject.completion_data.to_yaml)
          .to match_approval("completions/whitelist")
      end
    end
  end

  context "with a command that has nested command aliases" do
    let(:fixture) { :nested_aliases }

    describe '#completion_data' do
      it "returns a data structure that includes all command full names" do
        expect(subject.completion_data.to_yaml)
          .to match_approval("completions/nested_aliases")
      end
    end
  end
end
