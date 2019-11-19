require 'spec_helper'

describe Array do
  describe '#indent' do
    subject { ["root:", "  indented:"] }
    it "prepends each element with spaces" do
      expect(subject.indent 2).to eq ["  root:", "    indented:"]
    end
  end
end
