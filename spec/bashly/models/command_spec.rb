require 'spec_helper'

describe Models::Command do
  let(:fixture) { :basic_command }

  subject do
    options = load_fixture('models/commands')[fixture]
    described_class.new options
  end

  describe '#action_name' do
    context "when it is the root command" do
      it "returns root" do
        expect(subject.action_name).to eq "root"
      end
    end

    context "when it is a sub-command" do
      let(:fixture) { :git_status }

      it "returns its name" do
        expect(subject.action_name).to eq "status"
      end
    end

    context "when it is a sub-sub-command" do
      let(:fixture) { :docker_container_run }

      it "returns its full name excluding the root" do
        expect(subject.action_name).to eq "container run"
      end
    end
  end

  describe '#aliases' do
    context "with long and short options" do
      it "returns an array of both long and short values" do
        expect(subject.aliases).to eq ["get", "g"]
      end
    end

    context "with long option only" do
      let(:fixture) { :long_only_command }

      it "returns an array with the long value" do
        expect(subject.aliases).to eq ["get"]
      end
    end
  end

  describe '#args' do
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
    let(:fixture) { :docker }

    it "returns an array of command names" do
      expect(subject.command_names).to eq ["container", "image"]
    end
  end

  describe '#commands' do
    let(:fixture) { :docker }

    it "returns an array of Command objects" do
      expect(subject.commands).to be_an Array
      expect(subject.commands.first).to be_a Models::Command
    end

    it "sets the parents property of its commands" do
      expect(subject.commands.first.parents).to eq ["docker"]
    end
  end

  describe '#deep_commands' do
    let(:fixture) { :docker }

    it "returns an array of all commands in the tree" do
      expect(subject.deep_commands.map &:full_name).to eq ["docker container", "docker container run", "docker container stop", "docker image"]
    end
  end

  describe '#default_command' do
    let(:fixture) { :default_command }

    it "returns a Command object of the first default command" do
      expect(subject.default_command).to be_a Models::Command
      expect(subject.default_command.name).to eq 'get'
    end    
  end

  describe '#environment_cariables' do
    it "returns an array of EnvironemntVariable objects" do
      expect(subject.environment_variables).to be_an Array
      expect(subject.environment_variables.first).to be_a Models::EnvironmentVariable
    end
  end

  describe '#filename' do
    context "when it is the root command" do
      it "returns root_command.sh" do
        expect(subject.filename).to eq "root_command.sh"
      end
    end

    context "when it is a sub command" do
      let(:fixture) { :git_status }

      it "returns the action name as file" do
        expect(subject.filename).to eq "status_command.sh"
      end
    end

    context "when it is a sub sub command" do
      let(:fixture) { :docker_container_run }

      it "returns the action name as file" do
        expect(subject.filename).to eq "container_run_command.sh"
      end
    end
  end

  describe '#flags' do
    it "returns an array of Flag objects" do
      expect(subject.flags).to be_an Array
      expect(subject.flags.first).to be_a Models::Flag
    end
  end

  describe '#function_name' do
    let(:fixture) { :docker_container_run }

    it "returns the full name underscored" do
      expect(subject.function_name).to eq "docker_container_run"
    end
  end

  describe '#full_name' do
    context "when it does not have a parent" do
      it "returns the name" do
        expect(subject.full_name).to eq "get"
      end
    end

    context "when it has a parent" do
      let(:fixture) { :git_status }

      it "returns the a string with all parents joined" do
        expect(subject.full_name).to eq "git status"
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
        expect(subject.load_user_file 'notfound.sh').to eq "# :spec/tmp/src/notfound.sh\necho \"error: cannot load file\""
      end
    end
  end

  describe '#required_args' do
    it "returns an array of only the required Argument objects" do
      expect(subject.required_args.size).to eq 1
      expect(subject.required_args.first.name).to eq "source"
    end
  end

  describe '#required_environment_variables' do
    it "returns an array of only the required Argument objects" do
      expect(subject.required_environment_variables.size).to eq 1
      expect(subject.required_environment_variables.first.name).to eq "secret_key"
    end
  end

  describe '#required_flags' do
    it "returns an array of only the required Flag objects" do
      expect(subject.required_flags.size).to eq 1
      expect(subject.required_flags.first.long).to eq "--force"
    end
  end

  describe '#root_command?' do
    context "when the command has no parents" do
      it "returns true" do
        expect(subject.root_command?).to be true
      end
    end

    context "when the command has parents" do
      let(:fixture) { :git_status }

      it "returns false" do
        expect(subject.root_command?).to be false
      end
    end
  end

  describe '#short_flag_exist?' do
    let(:fixture) { :flag_hog }

    context "when the command has this short flag" do
      it "returns true" do
        expect(subject.short_flag_exist? "-h").to be true
      end
    end

    context "when the command does not have this short flag" do
      it "returns false" do
        expect(subject.short_flag_exist? "-s").to be false
      end
    end
  end

  describe '#usage_string' do
    context "when no args and no commands are defined" do
      let(:fixture) { :git_status }

      it "returns a string suitable to be used as a usage pattern" do
        expect(subject.usage_string).to eq "git status [options]"
      end
    end

    context "when args are defined" do
      it "includes them in the usage string" do
        expect(subject.usage_string).to eq "get SOURCE [TARGET] [options]"
      end      
    end

    context "when commands are defined" do
      let(:fixture) { :docker }

      it "includes [command] in the usage string" do
        expect(subject.usage_string).to eq "docker [command] [options]"
      end      
    end
  end

  describe '#verify' do
    context "when commands and flags are present" do
      let(:fixture) { :invalid_with_flags }

      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /cannot be at the same level/)
      end
    end

    context "when commands and args are present" do
      let(:fixture) { :invalid_with_args }

      it "raises an error" do
        expect { subject.verify }.to raise_error(ConfigurationError, /cannot be at the same level/)
      end
    end
  end

end
