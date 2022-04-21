require 'spec_helper'

describe Script::Base do
  let(:options) { {"name" => "file", "help" => "line one\nline two"} }
  subject { described_class.new options }

  describe '::option_keys' do
    it "returns an empty array" do
      expect(described_class.option_keys).to eq []
    end
  end

  describe '#initialize' do
    context "with invalid options" do
      let(:options) { "not-a-hash" }
      
      it "raises an error" do
        expect { subject }.to raise_error(Bashly::Error, /Invalid options/)
      end
    end
  end

  describe '#method_missing' do
    context "when the method is not a valid option key" do
      it "raises an error" do
        expect { subject.no_such_option }.to raise_error(NoMethodError)
      end
    end
  end

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
