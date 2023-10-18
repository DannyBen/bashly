describe ConfigValidator do
  fixtures = load_fixture 'script/validations'

  describe '#validate' do
    fixtures.each do |fixture, options|
      validator = described_class.new options

      context "with :#{fixture}" do
        it 'raises an error' do
          expect { validator.validate }.to raise_approval("validations/#{fixture}")
        end
      end
    end
  end
end
