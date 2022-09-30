require 'spec_helper'

describe Script::Command do
  let(:fixture) { :basic_command }
  fixtures = load_fixture('script/commands')
  subject do
    result = described_class.new fixtures[fixture]
    result.parents = result.options['parents']
    result
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

  describe '#all_full_names' do
    let(:fixture) { :nested_aliases }
    
    it "returns an array of all full names including aliases" do
      expect(subject.deep_commands.last.all_full_names.to_yaml)
        .to match_approval('script/command/nested_aliases')
    end
  end

  describe '#args' do
    it "returns an array of Argument objects" do
      expect(subject.args).to be_an Array
      expect(subject.args.first).to be_a Script::Argument
    end
  end

  describe '#caption_string' do
    it "returns a string containing the name and summary" do
      expect(subject.caption_string).to eq "get - get something from somewhere"
    end

    context "when help is not defined" do
      let(:fixture) { :helpless }

      it "returns the full name only" do
        expect(subject.caption_string).to eq "helpless"
      end
    end
  end

  describe '#command_aliases' do
    let(:fixture) { :aliases }

    it "returns an array of command aliases" do
      expect(subject.command_aliases).to eq ["download", "d", "pull", "upload", "u", "push", "update", "upgrade"]
    end
  end

  describe '#command_help_data' do
    let(:fixture) { :exposed }

    it "returns a hash suitable for showing command and exposed subcommand help" do
      expect(subject.command_help_data.to_yaml)
        .to match_approval('script/command/exposed_commands')
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
      expect(subject.commands.first).to be_a Script::Command
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

  describe '#default_arguments' do
    let(:fixture) { :default_values }

    it "returns an array of only the Argument objects that have default" do
      expect(subject.default_args.size).to eq 1
      expect(subject.default_args.first.name).to eq "files"
    end
  end

  describe '#default_command' do
    let(:fixture) { :default_command }

    it "returns a Command object of the first default command" do
      expect(subject.default_command).to be_a Script::Command
      expect(subject.default_command.name).to eq 'get'
    end
  end

  describe '#default_flags' do
    let(:fixture) { :default_values }

    it "returns an array of only the Flags objects that have default" do
      expect(subject.default_flags.size).to eq 1
      expect(subject.default_flags.first.long).to eq "--format"
    end
  end

  describe '#environment_cariables' do
    it "returns an array of EnvironemntVariable objects" do
      expect(subject.environment_variables).to be_an Array
      expect(subject.environment_variables.first).to be_a Script::EnvironmentVariable
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

    context "when filename is provided by the user's config" do
      let(:fixture) { :custom_filename }

      it "returns its value" do
        expect(subject.filename).to eq "ops/run_command.sh"
      end
    end
  end

  describe '#filters' do
    context "when filters are not defined" do
      it "returns nil" do
        expect(subject.filters).to be_nil
      end
    end

    context "when filters is defined" do
      let(:fixture) { :filters_array }

      it "returns it as is" do
        expect(subject.filters).to eq %w[docker_running redis_running]
      end
    end
  end

  describe '#flags' do
    it "returns an array of Flag objects" do
      expect(subject.flags).to be_an Array
      expect(subject.flags.first).to be_a Script::Flag
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

  describe '#global_flags?' do
    context "when a command has flags and commands" do
      let(:fixture) { :mode_global_flags }

      it "returns true" do
        expect(subject.global_flags?).to be_truthy
      end
    end

    context "when a command has flags but no commands" do
      let(:fixture) { :mode_flags }

      it "returns false" do
        expect(subject.global_flags?).to be_falsy
      end
    end

    context "when a command has commands but no flags" do
      let(:fixture) { :mode_commands }

      it "returns false" do
        expect(subject.global_flags?).to be_falsy
      end
    end
  end

  describe '#group_string' do
    it "returns a string suitable for showing the group in usage" do
      expect(subject.group_string).to eq "Commands:"
    end

    context "when the command is grouped" do
      let(:fixture) { :grouped }

      it "returns group string" do
        expect(subject.group_string).to eq "Repository Commands:"
      end
    end
  end

  describe '#load_user_file' do
    before do      
      Dir.mkdir 'spec/tmp/src' unless Dir.exist? 'spec/tmp/src'
      File.write 'spec/tmp/src/test.sh', "hello Command#load_user_file"
    end

    it "returns the contents of a file in ./src along with a header " do
      expect(subject.load_user_file 'test.sh').to eq "# spec/tmp/src/test.sh\nhello Command#load_user_file"
    end

    context "when the file is not found" do
      it "returns a string containing a friendly error message" do
        expect(subject.load_user_file 'notfound.sh').to eq "# spec/tmp/src/notfound.sh\necho \"error: cannot load file\""
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

  describe '#repeatable_arg_exist?' do
    context "when the command does not have any repeatable flags" do
      it "returns false" do
        expect(subject.repeatable_arg_exist?).to be false
      end
    end

    context "when the command has at least one repeatable flag" do
      let(:fixture) { :repeatable_arg }

      it "returns true" do
        expect(subject.repeatable_arg_exist?).to be true
      end
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

  describe '#summary_string' do
    it "returns the user defined summary" do
      expect(subject.summary_string).to eq "get something from somewhere"
    end

    context "when the command is the default" do
      let(:fixture) { :default_command }

      it "returns group string" do
        expect(subject.default_command.summary_string).to eq "get this (default)"
      end
    end
  end

  describe '#mode' do
    context "when flags and commands are defined" do
      let(:fixture) { :mode_global_flags }

      it "returns :global_flags" do
        expect(subject.mode).to eq :global_flags
      end
    end

    context "when only commands are defined" do
      let(:fixture) { :mode_commands }

      it "returns :commands" do
        expect(subject.mode).to eq :commands
      end
    end

    context "when args and flags are defined" do
      let(:fixture) { :mode_args_and_flags }

      it "returns :args_and_flags" do
        expect(subject.mode).to eq :args_and_flags
      end
    end

    context "when only args are defined" do
      let(:fixture) { :mode_args }

      it "returns :args" do
        expect(subject.mode).to eq :args
      end
    end

    context "when only flags are defined" do
      let(:fixture) { :mode_flags }

      it "returns :flags" do
        expect(subject.mode).to eq :flags
      end
    end

    context "when nothing is defined" do
      let(:fixture) { :mode_empty }

      it "returns :empty" do
        expect(subject.mode).to eq :empty
      end
    end
  end

  describe '#usage_string' do
    context "when flags and commands are defined" do
      let(:fixture) { :mode_global_flags }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get [OPTIONS] COMMAND"
      end
    end

    context "when only commands are defined" do
      let(:fixture) { :mode_commands }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get COMMAND"
      end
    end

    context "when args and flags are defined" do
      let(:fixture) { :mode_args_and_flags }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get SOURCE [TARGET] [OPTIONS] [PARAMS...]"
      end
    end

    context "when only args are defined" do
      let(:fixture) { :mode_args }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get SOURCE [TARGET] [PARAMS...]"
      end
    end

    context "when only flags are defined" do
      let(:fixture) { :mode_flags }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get [OPTIONS] [PARAMS...]"
      end

      context "when it has a parent" do
        let(:fixture) { :flags_only_command }

        it "returns the correct string" do
          expect(subject.usage_string).to eq "git status [OPTIONS]"
        end
      end
    end

    context "when nothing is defined" do
      let(:fixture) { :mode_empty }

      it "returns the correct string" do
        expect(subject.usage_string).to eq "get [PARAMS...]"
      end

      context "when it has a parent" do
        let(:fixture) { :git_status }

        it "returns the correct string" do
          expect(subject.usage_string).to eq "git status"
        end
      end
    end
  end

  describe '#whitelisted_args' do
    let(:fixture) { :whitelist }

    it "returns an array of args that have a whitelist" do
      expect(subject.whitelisted_args.size).to eq 1
      expect(subject.whitelisted_args.first.name).to eq "region"
    end
  end

  describe '#whitelisted_flags' do
    let(:fixture) { :whitelist }

    it "returns an array of flags that have a whitelist" do
      expect(subject.whitelisted_flags.size).to eq 1
      expect(subject.whitelisted_flags.first.long).to eq "--user"
    end
  end

end
