require 'spec_helper'

describe Script::Base do
  let(:options) { {"name" => "file", "help" => "line one\nline two"} }
  subject { described_class.new options }

  describe '#optional' do
    context "when required is false" do
      it "returns true" do
        expect(subject.optional).to be true
      end
    end

    context "when required is true" do
      let(:options) { {"name" => "file", "required" => true} }
      it "returns false" do
        expect(subject.optional).to be false
      end
    end
  end

  describe '#help' do
    let(:options) { {"name" => "file"} }
    it "defaults to an empty string" do
      expect(subject.help).to be_a String
      expect(subject.help).to eq ""
    end
  end

  describe '#summary' do
    it "returns the first line of the help string" do
      expect(subject.summary).to eq "line one"
    end

    context "when help is empty" do
      let(:options) { {"name" => "file"} }
      it "returns an empty string" do
        expect(subject.summary).to eq ""
      end
    end
  end
end
