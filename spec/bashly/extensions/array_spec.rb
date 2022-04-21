require 'spec_helper'

describe Array do
  describe '#indent' do
    subject { ["root:", "  indented:"] }
    it "prepends each element with spaces" do
      expect(subject.indent 2).to eq ["  root:", "    indented:"]
    end

    context "when offset is 0" do
      it "returns the array as is" do
        expect(subject.indent 0).to eq subject
      end
    end
  end
end
