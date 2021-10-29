require 'spec_helper'

# This spec tests that the generated bash scripts are actually doing
# what they are supposed to do, and running without errors.
# It will run several tests on all the configuration files in the examples
# folder

describe 'generated bash scripts' do
  # Test public examples from the examples folder...
  examples = Dir["examples/*"].select { |f| File.directory? f }

  # ...as well as internal examples, not suitable for public view
  fixtures = Dir["spec/fixtures/workspaces/*"].select do |f|
    File.directory? f and File.exist? "#{f}/test.sh"
  end

  test_cases = fixtures + examples

  # To test one example, run: EXAMPLE=yaml bundle exec run spec examples
  test_cases = ["examples/#{ENV['EXAMPLE']}"] if ENV['EXAMPLE']

  leeway = ENV['CI'] ? 30 : 0

  test_cases.each do |example|
    approval_name = example.gsub "spec/fixtures/workspaces", "fixtures"

    describe example do
      it "works" do
        output = "not executed"
        Dir.chdir example do
          output = `bash test.sh 2>&1`
        end
        
        # Use .diff to give CI some leeway, since its shell differs soemtimes
        # This was observed in at least these two cases:
        # - The "+ ..." shell messages driven by `set -x` have no space
        # - The order of our `inspect_args` sometimes differs
        expect(output).to match_approval(approval_name).diff(leeway)
      end
    end
  end

end
