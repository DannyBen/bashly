require "spec_helper"

describe Settings do
  subject { described_class }

  describe "standard value" do
    it "returns a predefined default value" do
      expect(subject.tab_indent).to be false
    end

    context "when its corresponding env var is set" do
      before do
        Settings.tab_indent = nil
        @original_value = ENV["BASHLY_TAB_INDENT"]
      end

      after do
        ENV["BASHLY_TAB_INDENT"] = @original_value
      end

      it "returns true when the env var is truthy" do
        %w[1 true yes].each do |value|
          ENV["BASHLY_TAB_INDENT"] = value
          expect(subject.tab_indent).to be true
        end
      end

      it "returns false when the env var is falsy" do
        %w[0 false no].each do |value|
          ENV["BASHLY_TAB_INDENT"] = value
          expect(subject.tab_indent).to be false
        end
      end

      it "returns the env var value itself otherwise" do
        ENV["BASHLY_TAB_INDENT"] = "anything at all"
        expect(subject.tab_indent).to eq ENV["BASHLY_TAB_INDENT"]
      end
    end
  end

  describe "::env" do
    it "returns :development by default" do
      expect(subject.env).to eq :development
    end
  end

  describe "::production?" do
    it "returns false by default" do
      expect(subject.production?).to be false
    end

    context "when env == :production" do
      before { subject.env = :production }
      after { subject.env = nil }

      it "returns true" do
        expect(subject.production?).to be true
      end
    end
  end
end
