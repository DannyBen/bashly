require 'spec_helper'

describe Array do
  describe '#indent' do
    subject { "hello" }
    it "prepends the string with spaces" do
      expect(subject.indent 3).to eq "   hello"
    end
  end

  describe '#to_underscore' do
    subject { "Some String" }

    it "does not mutate the source" do
      subject.to_underscore
      expect(subject).to eq "Some String"
    end

    context "with CamelCased argument" do
      subject { "NotCamelCase" }

      it "returns its snake_case version" do
        expect(subject.to_underscore).to eq "not_camel_case"
      end
    end

    context "with any string with spaces" do
      subject { "in any case" }

      it "returns its snake_case version" do
        expect(subject.to_underscore).to eq "in_any_case"
      end
    end
  end
end
