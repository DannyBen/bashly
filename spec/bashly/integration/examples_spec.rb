# This spec tests that the generated bash scripts are actually doing
# what they are supposed to do, and running without errors.
# It will run several tests on all the configuration files in the examples
# folder
#
# To only test examples containing a certain string in their path, run:
# EXAMPLE=yaml bundle exec run spec examples

describe 'generated bash scripts' do
  # Test public examples from the examples folder...
  examples = Dir['examples/*'].select { |f| File.directory? f }

  # ...as well as internal examples, not suitable for public view
  fixtures = Dir['spec/fixtures/workspaces/*'].select do |f|
    File.directory? f and File.exist? "#{f}/test.sh"
  end

  test_cases = fixtures + examples

  # Allow up to a certain string distance from the approval text in CI
  leeway = ENV['CI'] ? 40 : 0

  test_cases.each do |example|
    approval_name = example.gsub 'spec/fixtures/workspaces', 'fixtures'

    next if ENV['EXAMPLE'] && !example.include?(ENV['EXAMPLE'])

    describe example do
      it 'is executed properly' do
        output = 'not executed'
        Dir.chdir example do
          output = `bash test.sh 2>&1`
        end

        # Use .diff to give CI some leeway, since its shell differs sometimes
        # This was observed in at least these two cases:
        # - The "+ ..." shell messages driven by `set -x` have no space
        # - The order of our `inspect_args` sometimes differs
        # - The result of the `deps` array sometimes differs
        expect(output).to match_approval(approval_name).diff(leeway)
      end
    end
  end
end
