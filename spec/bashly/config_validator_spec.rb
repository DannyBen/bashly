require 'spec_helper'

describe ConfigValidator do
  fixtures = load_fixture 'script/validations'
  subject { described_class.new options }

  describe '#validate' do
    fixtures.each do |fixture, options|
      context "with :#{fixture}" do
        let(:options) { options }

        it 'raises an error' do
          expect { subject.validate }.to raise_approval("validations/#{fixture}")
        end
      end
    end
  end
end
