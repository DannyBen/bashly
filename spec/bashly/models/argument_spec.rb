require 'spec_helper'

describe Models::Argument do
  let(:options) { {"name" => "file"} }
  subject { described_class.new options }

  describe '#optional' do
    context "when the argument is optional" do
      it "returns true" do
        expect(subject.optional).to be true
      end
    end

    context "when the argument is required" do
      let(:options) { {"name" => "file", "required" => true} }
      it "returns false" do
        expect(subject.optional).to be false
      end
    end
  end

  describe '#usage_string' do
    it "returns a string suitable to be used as a usage pattern" do
      expect(subject.usage_string).to eq "[FILE]"
    end

    context "when the argument is required" do
      let(:options) { {"name" => "file", "required" => true} }
      it "returns a string suitable to be used as a usage pattern" do
        expect(subject.usage_string).to eq "FILE"
      end
    end
  end

  describe '#summary' do
    let(:options) { {"name" => "file", "help" => "summary\nadditional help"} }
    
    it "returns the first line of the help string" do
      expect(subject.summary).to eq "summary"
    end

    context "when help is empty" do
      let(:options) { {"name" => "file"} }
      it "returns an empty string" do
        expect(subject.summary).to eq ""
      end
    end
  end
end
