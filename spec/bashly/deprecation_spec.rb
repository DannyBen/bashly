require 'spec_helper'

describe Deprecation do
  subject { described_class.new old, **options }
  let(:old) { 'old' }
  let(:options) { { replacement: 'new', reference: 'https://somewhere' } }

  describe '#message' do
    it "returns a nicey formatted deprecation string" do
      expect(subject.message).to match_approval('deprecation/message')
    end
  end
end
