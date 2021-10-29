require 'spec_helper'

describe AssetHelper do
  subject { Class.new { include AssetHelper }.new }
  let(:path) { "version.rb" }

  describe '#asset' do
    it "returns a path to any file in the source tree" do
      expect(subject.asset path).to end_with "lib/bashly/#{path}"
    end
  end

  describe '#asset_content' do
    it "returns the contents of any file in the source tree" do
      expect(subject.asset_content path).to eq File.read(subject.asset path)
    end
  end  
end
