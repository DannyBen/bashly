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

  describe '#verify' do
    context "when the argument has no name" do
      let(:fixture) { :invalid_without_name }

      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /must have a name/)
      end
    end
  end

end
