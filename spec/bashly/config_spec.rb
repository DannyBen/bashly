require 'spec_helper'

describe Config do
  let(:config) { {"hello" => "world"} }
  subject { described_class.new config }

  describe '::new' do
    it "returns a hash (and not a Config object)" do
      expect(subject).to be_a Hash
    end
  end

  context "with a hash argument" do
    it "returns the hash" do
      expect(subject["hello"]).to eq "world"      
    end
  end

  context "with a string argument" do
    let(:config) { "spec/fixtures/config.yml" }
    
    it "treats the string as a path to YAML and loads it" do
      expect(subject["loaded"]).to eq "yes indeed"
    end

    context "when the loaded YAML contains import directives" do
      let(:config) { "spec/fixtures/import.yml" }

      it "evaluates them" do
        expect(subject["commands"].first['loaded']).to eq "yes indeed"
      end
    end
  end

end
