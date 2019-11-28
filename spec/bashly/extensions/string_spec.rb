require 'spec_helper'

describe Array do
  describe '#sanitize_for_print' do
    subject { %Q[this is\na "new line"] }
    it "escapes newlines and quotes" do
      expect(subject.sanitize_for_print).to eq "this is\\na \\\"new line\\\""
    end
  end

  describe '#indent' do
    subject { "hello" }
    it "prepends the string with spaces" do
      expect(subject.indent 3).to eq "   hello"
    end
  end

  describe '#wrap' do
    subject { "a long line of text that is going to be wrapped, fingers crossed!" }
    it "wraps the string to the specified length" do
      expect(subject.wrap 30).to eq "a long line of text that is\ngoing to be wrapped, fingers\ncrossed!"
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

    context "with any string with spaces and hyphens" do
      subject { "in any-case" }

      it "returns its snake_case version" do
        expect(subject.to_underscore).to eq "in_any_case"
      end
    end
  end

  describe '#lint' do
    subject { "one\ntwo\n\nthree\n\n\nfour\n\n\n\n" }

    it "replaces two or more newlines with two newlines" do
      expect(subject.lint).to eq "one\ntwo\n\nthree\n\nfour\n\n"
    end
  end
end
