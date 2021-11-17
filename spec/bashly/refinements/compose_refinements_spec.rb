require 'spec_helper'

describe ComposeRefinements do
  using ComposeRefinements
  
  subject do
    {
      "array" => [string, array, hash],
      "args" => imported_array
    }
  end

  let(:string) { "hello" }
  let(:array) { [string, hash] }
  let(:hash) { { "key" => 'value', "import" => fixture } }
  let(:imported_array) { { "import" => 'spec/fixtures/array.yml' } }
  let(:fixture) { 'spec/fixtures/config.yml' }

  describe '#compose' do
    it "calls #compose on all elements that respond to #compose" do
      expect(subject.compose.to_yaml).to match_approval "refinements/compose/array"
    end

    context "when the import path does not exist" do
      subject { { import: "no-such-file.yml" } }
      
      it "raises ConfigurationError" do
        expect { subject.compose }.to raise_approval("refinements/compose/error-not-found")
      end
    end

    context "when the import path does not contain a valid YAML front matter" do
      subject { { import: "examples/minimal/src/root_command.sh" } }
      
      it "raises ConfigurationError" do
        expect { subject.compose }.to raise_approval("refinements/compose/error-invalid")
      end
    end
  end
end
