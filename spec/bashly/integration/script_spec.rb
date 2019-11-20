require 'spec_helper'

# This spec tests that the generated bash scripts are actually doing
# what they are supposed to do, and running without errors.
# It will run several tests on all the configuration files in the examples
# folder

describe 'generated bash scripts' do
  examples = Dir["examples/*"].select { |f| File.directory? f }

  examples.each do |example|
    describe example do
      it "works" do
        output = "not executed"
        Dir.chdir example do
          output = `bash test.sh 2>&1`
        end
        # test with .diff, to allow some variations betwen different machines
        # (i.e. CI)
        expect(output).to match_fixture(example).diff(40)
      end
    end
  end

end
