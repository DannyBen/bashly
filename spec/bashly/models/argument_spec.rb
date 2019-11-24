require 'spec_helper'

describe Models::Argument do
  let(:options) { {"name" => "file"} }
  subject { described_class.new options }

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

end
