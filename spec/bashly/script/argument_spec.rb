require 'spec_helper'

describe Script::Argument do
  let(:fixture) { :basic_argument }

  subject do
    options = load_fixture('script/arguments')[fixture]
    described_class.new options
  end

  describe '#usage_string' do
    it "returns a string suitable to be used as a usage pattern" do
      expect(subject.usage_string).to eq "[FILE]"
    end

    context "when the argument is required" do
      let(:fixture) { :required }

      it "returns a string suitable to be used as a usage pattern" do
        expect(subject.usage_string).to eq "FILE"
      end
    end
  end

  describe '#label' do
    it "returns a string suitable to be used as a compact usage pattern" do
      expect(subject.label).to eq "FILE"
    end

    context "with a repeatable arg" do
      let(:fixture) { :repeatable }

      it "adds a ... suffix" do
        expect(subject.label).to eq "FILE..."
      end
    end
  end
end
