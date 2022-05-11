require 'spec_helper'

describe ConfigValidator do
  fixtures = load_fixture 'script/validations'
  subject { described_class.new options }

  describe '#validate' do
    fixtures.each do |fixture, options|
      context "with :#{fixture}" do
        let(:options) { options }

        it "raises an error" do
          expect { subject.validate }.to raise_approval("validations/#{fixture}")
        end
      end
    end
  end

  context "deprecations" do
    fixtures = load_fixture 'script/deprecations'

    describe '#validate' do
      fixtures.each do |fixture, options|
        context "with :#{fixture}" do
          let(:options) { options }

          it "stores deprecations" do
            subject.validate
            deprecations = subject.deprecations.map(&:to_h).to_yaml
            expect(deprecations).to match_approval("script/deprecations/#{fixture}")
          end
        end
      end
    end
  end

end
