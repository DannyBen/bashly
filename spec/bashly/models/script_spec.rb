require 'spec_helper'

describe Models::Script do
  subject { described_class.new command }
  let(:command) { Models::Command.new config }
  let(:config) { load_fixture('models/commands')[fixture] }
  let(:fixture) { :basic_command }

  describe '#code' do
    context "without function name" do
      it "returns the complete script" do
        lines = subject.code.split "\n"
        expect(lines[0..12].join("\n")).to match_approval('models/script/code')
        expect(lines[-1]).to eq 'run "$@"'
      end
    end

    context "with function name" do
      subject { described_class.new command, 'my_super_function' }

      it "returns the complete script wrapped in a function without a bash3 bouncer" do
        lines = subject.code.split "\n"
        expect(lines[0..12].join("\n")).to match_approval('models/script/code-wrapped')
        expect(lines[-1]).to eq '(return 0 2>/dev/null) || my_super_function "$@"'
      end
    end

    context "with a custom script header" do
      let(:fixture) { :custom_header }
      let(:header_text) { "This is an injected header" }

      before do
        system "mkdir -p spec/tmp/src"
        File.write "spec/tmp/src/header.sh", header_text
      end

      it "uses the custom header instead of the factory one" do
        lines = subject.code.split "\n"
        expect(lines[0]).to eq header_text
        expect(lines[1]).to eq "# :command.root_command"
      end
    end
  end

end
