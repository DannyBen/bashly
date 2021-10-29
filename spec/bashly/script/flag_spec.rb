require 'spec_helper'

describe Script::Flag do
  let(:options) { {"long" => "--help", "short" => "-h", "help" => "show this help"} }
  subject { described_class.new options }

  describe '#aliases' do
    context "with long and short options" do
      it "returns an array of both long and short values" do
        expect(subject.aliases).to eq ["--help", "-h"]
      end
    end

    context "with long option only" do
      let(:options) { {"long" => "--long"} }
      it "returns an array with the long value" do
        expect(subject.aliases).to eq ["--long"]
      end
    end

    context "with short option only" do
      let(:options) { {"short" => "-s"} }
      it "returns an array with the short value" do
        expect(subject.aliases).to eq ["-s"]
      end
    end
  end

  describe '#name' do
    context "with both short and long options" do
      it "returns the long option" do
        expect(subject.name).to eq "--help"
      end
    end

    context "with long option only" do
      let(:options) { {"long" => "-l"} }
      it "returns the long option" do
        expect(subject.name).to eq "-l"
      end
    end

    context "with short option only" do
      let(:options) { {"short" => "-s"} }
      it "returns the short option" do
        expect(subject.name).to eq "-s"
      end
    end
  end

  describe '#usage_string' do
    it "returns a string suitable to be used as a usage pattern" do
      expect(subject.usage_string).to eq "--help, -h"
    end

    context "with extended: true" do
      context "when the flag is optional" do
        it "returns the same string as it does without extended" do
          expect(subject.usage_string extended: true).to eq subject.usage_string
        end
      end

      context "when the flag is required" do
        let(:options) { {"long" => "--mandatory", "required" => true} }
        it "appends (required) to the usage string" do
          expect(subject.usage_string extended: true).to eq "#{subject.usage_string} (required)"
        end        
      end
      
    end
  end

end
