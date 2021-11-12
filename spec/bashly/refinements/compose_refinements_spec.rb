require 'spec_helper'

describe ComposeRefinements, :focus do
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
  end
end
