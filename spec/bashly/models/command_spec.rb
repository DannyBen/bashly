require 'spec_helper'

describe Models::Command do
  let(:args) { [] }
  let(:flags) { [] }
  let(:commands) { [] }
  let(:options) {{
    "name" => "get",
    "short" => "g",
    "help" => "get something from somewhere",
    "args" => args,
    "flags" => flags,
    "commands" => commands,
  }}
  subject { described_class.new options }

  describe '#aliases' do
    context "with long and short options" do
      it "returns an array of both long and short values" do
        expect(subject.aliases).to eq ["get", "g"]
      end
    end

    context "with long option only" do
      let(:options) { {"name" => "get"} }
      it "returns an array with the long value" do
        expect(subject.aliases).to eq ["get"]
      end
    end
  end

  describe '#args' do
    let(:args) {[
      {"name" => "works"},
      {"name" => "splendidly"},
    ]}

    it "returns an array of Argument objects" do
      expect(subject.args).to be_an Array
      expect(subject.args.first).to be_a Models::Argument
    end
  end

  describe '#caption_string' do
    it "returns a string containing the name and summary" do
      expect(subject.caption_string).to eq "get - get something from somewhere"
    end
  end

  describe '#command_names' do
    let(:commands) {[{"name" => "add"}, {"name" => "remove"}]}
    it "returns an array of command names" do
      expect(subject.command_names).to eq ["add", "remove"]
    end
  end

  describe '#commands' do
    let(:commands) {[
      {"name" => "download"},
      {"name" => "upload"},
    ]}

    it "returns an array of Command objects" do
      expect(subject.commands).to be_an Array
      expect(subject.commands.first).to be_a Models::Command
    end

    it "sets the parent_name property of its subcommands" do
      expect(subject.commands.first.parent_name).to eq "get"
    end
  end

  describe '#flags' do
    let(:flags) {[
      {"long" => "--works"},
      {"long" => "--splendidly"},
    ]}

    it "returns an array of Flag objects" do
      expect(subject.flags).to be_an Array
      expect(subject.flags.first).to be_a Models::Flag
    end
  end

  describe '#full_name' do
    context "when it does not have a parent" do
      it "returns the name" do
        expect(subject.full_name).to eq "get"
      end
    end

    context "when it has a parent" do
      before { options['parent_name'] = 'super' }
      it "returns the name" do
        expect(subject.full_name).to eq "super get"
      end
    end
  end

  describe '#load_user_file' do
    before do      
      Dir.mkdir 'spec/tmp/src' unless Dir.exist? 'spec/tmp/src'
      File.write 'spec/tmp/src/test.sh', "hello Command#load_user_file"
    end

    it "returns the contents of a file in ./src along with a header " do
      expect(subject.load_user_file 'test.sh').to eq "# :spec/tmp/src/test.sh\nhello Command#load_user_file"
    end

    context "when the file is not found" do
      it "returns a string containing a friendly error message" do
        expect(subject.load_user_file 'notfound.sh').to eq "# :spec/tmp/src/notfound.sh\n# error: cannot load file"
      end
    end
  end

  describe '#required_args' do
    let(:args) {[
      {"name" => "source", "required" => true},
      {"name" => "target"},
    ]}

    it "returns an array of only the required Argument objects" do
      expect(subject.required_args.size).to eq 1
      expect(subject.required_args.first.name).to eq "source"
    end
  end

  describe '#required_flags' do
    let(:flags) {[
      {"long" => "--source", "required" => true},
      {"long" => "--target"},
    ]}

    it "returns an array of only the required Flag objects" do
      expect(subject.required_flags.size).to eq 1
      expect(subject.required_flags.first.long).to eq "--source"
    end
  end

  describe '#summary' do
    let(:options) { {"name" => "get", "help" => "summary\nadditional help"} }
    it "returns the first line of the help string" do
      expect(subject.summary).to eq "summary"
    end

    context "when help is empty" do
      let(:options) { {"name" => "get"} }
      it "returns an empty string" do
        expect(subject.summary).to eq ""
      end
    end
  end

  describe '#usage_string' do
    it "returns a string suitable to be used as a usage pattern" do
      expect(subject.usage_string).to eq "get [options]"
    end

    context "when args are defined" do
      let(:args) {[
        {"name" => "source", "required" => true},
        {"name" => "target"},
      ]}
      it "includes them in the usage string" do
        expect(subject.usage_string).to eq "get SOURCE [TARGET] [options]"
      end      
    end

    context "when commands are defined" do
      let(:commands) {[{"name" => "local"}]}
      it "includes [command] in the usage string" do
        expect(subject.usage_string).to eq "get [command] [options]"
      end      
    end
  end

  describe '#verify' do
    let(:commands) { [{"name" => "subcommand"}] }

    context "when commands and flags are present" do
      let(:flags) { [{"long" => "--long"}] }
      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /cannot be at the same level/)
      end
    end

    context "when commands and args are present" do
      let(:args) { [{"name" => "file"}] }
      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /cannot be at the same level/)
      end
    end

    context "when commands are present and it is a subcommand itself" do
      before { options['parent_name'] = 'parent_command' }
      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /Nested commands are not supported/)
      end
    end
  end

end
