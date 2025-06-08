describe Script::Command do
  subject do
    result = described_class.new fixtures[fixture]
    result.parents = result.options['parents']
    result
  end

  let(:fixtures) { load_fixture 'script/commands' }
  let(:fixture) { :basic_command }

  describe '#action_name' do
    context 'when it is the root command' do
      it 'returns root' do
        expect(subject.action_name).to eq 'root'
      end
    end

    context 'when it is a sub-command' do
      let(:fixture) { :git_status }

      it 'returns its name' do
        expect(subject.action_name).to eq 'status'
      end
    end

    context 'when it is a sub-sub-command' do
      let(:fixture) { :docker_container_run }

      it 'returns its full name excluding the root' do
        expect(subject.action_name).to eq 'container run'
      end
    end
  end

  describe '#aliases' do
    context 'with long and short options' do
      it 'returns an array of both long and short values' do
        expect(subject.aliases).to eq %w[get g]
      end
    end

    context 'with long option only' do
      let(:fixture) { :long_only_command }

      it 'returns an array with the long value' do
        expect(subject.aliases).to eq ['get']
      end
    end
  end

  describe '#caption_string' do
    it 'returns a string containing the name and summary' do
      expect(subject.caption_string).to eq 'get - get something from somewhere'
    end

    context 'when help is not defined' do
      let(:fixture) { :helpless }

      it 'returns the full name only' do
        expect(subject.caption_string).to eq 'helpless'
      end
    end
  end

  describe '#filename' do
    context 'when it is the root command' do
      it 'returns root_command.sh' do
        expect(subject.filename).to eq 'root_command.sh'
      end
    end

    context 'when it is a sub command' do
      let(:fixture) { :git_status }

      it 'returns the action name as file' do
        expect(subject.filename).to eq 'status_command.sh'
      end
    end

    context 'when it is a sub sub command' do
      let(:fixture) { :docker_container_run }

      it 'returns the action name as file' do
        expect(subject.filename).to eq 'container_run_command.sh'
      end
    end

    context "when filename is provided by the user's config" do
      let(:fixture) { :custom_filename }

      it 'returns its value' do
        expect(subject.filename).to eq 'ops/run_command.sh'
      end
    end

    context 'when settings.commands_dir is set' do
      let(:fixture) { :docker_container_run }

      before { Settings.commands_dir = 'commands' }
      after  { Settings.commands_dir = nil }

      it 'returns the nested path of the action name' do
        expect(subject.filename).to eq 'commands/container/run.sh'
      end
    end
  end

  describe '#filters' do
    context 'when filters are not defined' do
      it 'returns nil' do
        expect(subject.filters).to be_nil
      end
    end

    context 'when filters is defined' do
      let(:fixture) { :filters_array }

      it 'returns it as is' do
        expect(subject.filters).to eq %w[docker_running redis_running]
      end
    end
  end

  describe '#function_name' do
    let(:fixture) { :docker_container_run }

    it 'returns the full name underscored' do
      expect(subject.function_name).to eq 'docker_container_run'
    end

    context "when function is provided by the user's config" do
      let(:fixture) { :custom_function }

      it 'returns the requested function name' do
        expect(subject.function_name).to eq 'my_custom_function'
      end
    end
  end

  describe '#full_name' do
    context 'when it does not have a parent' do
      it 'returns the name' do
        expect(subject.full_name).to eq 'get'
      end
    end

    context 'when it has a parent' do
      let(:fixture) { :git_status }

      it 'returns the a string with all parents joined' do
        expect(subject.full_name).to eq 'git status'
      end
    end
  end

  describe '#group_string' do
    it 'returns a string suitable for showing the group in usage' do
      expect(subject.group_string).to eq 'Commands:'
    end

    context 'when the command is grouped' do
      let(:fixture) { :grouped }

      it 'returns group string' do
        expect(subject.group_string).to eq 'Repository Commands:'
      end
    end
  end

  describe '#has_unique_args_or_flags?' do
    context 'when the command has any args that are unique' do
      let(:fixture) { :unique_args }

      it 'returns true' do
        expect(subject.has_unique_args_or_flags?).to be true
      end
    end

    context 'when the command has any flags that are unique' do
      let(:fixture) { :unique_flags }

      it 'returns true' do
        expect(subject.has_unique_args_or_flags?).to be true
      end
    end

    context 'when the command has any subcommands with unique args' do
      let(:fixture) { :unique_args_deep }

      it 'returns true' do
        expect(subject.has_unique_args_or_flags?).to be true
      end
    end

    context 'when the command has any subcommands with unique flags' do
      let(:fixture) { :unique_flags_deep }

      it 'returns true' do
        expect(subject.has_unique_args_or_flags?).to be true
      end
    end

    context 'when the command does not have any uniques' do
      it 'returns false' do
        expect(subject.has_unique_args_or_flags?).to be false
      end
    end
  end

  describe '#load_user_file' do
    before do
      FileUtils.mkdir_p 'spec/tmp/src'
      File.write 'spec/tmp/src/test.sh', 'hello Command#load_user_file'
    end

    it 'returns the contents of a file in ./src along with a header' do
      expect(subject.load_user_file('test.sh')).to eq "# spec/tmp/src/test.sh\nhello Command#load_user_file"
    end

    context 'when the file is not found' do
      it 'returns a string containing a friendly error message' do
        expect(subject.load_user_file('notfound.sh'))
          .to eq "# spec/tmp/src/notfound.sh\necho \"error: cannot load file\""
      end
    end

    context 'when the file is not found and placeholder is false' do
      it 'returns an empty string' do
        expect(subject.load_user_file('notfound.sh', placeholder: false))
          .to eq "# spec/tmp/src/notfound.sh\n"
      end
    end
  end

  describe '#mode' do
    context 'when flags and commands are defined' do
      let(:fixture) { :mode_global_flags }

      it 'returns :global_flags' do
        expect(subject.mode).to eq :global_flags
      end
    end

    context 'when only commands are defined' do
      let(:fixture) { :mode_commands }

      it 'returns :commands' do
        expect(subject.mode).to eq :commands
      end
    end

    context 'when args and flags are defined' do
      let(:fixture) { :mode_args_and_flags }

      it 'returns :args_and_flags' do
        expect(subject.mode).to eq :args_and_flags
      end
    end

    context 'when only args are defined' do
      let(:fixture) { :mode_args }

      it 'returns :args' do
        expect(subject.mode).to eq :args
      end
    end

    context 'when only flags are defined' do
      let(:fixture) { :mode_flags }

      it 'returns :flags' do
        expect(subject.mode).to eq :flags
      end
    end

    context 'when nothing is defined' do
      let(:fixture) { :mode_empty }

      it 'returns :empty' do
        expect(subject.mode).to eq :empty
      end
    end
  end

  describe '#root_command?' do
    context 'when the command has no parents' do
      it 'returns true' do
        expect(subject.root_command?).to be true
      end
    end

    context 'when the command has parents' do
      let(:fixture) { :git_status }

      it 'returns false' do
        expect(subject.root_command?).to be false
      end
    end
  end

  describe '#summary_string' do
    it 'returns the user defined summary' do
      expect(subject.summary_string).to eq 'get something from somewhere'
    end

    context 'when the command is the default' do
      let(:fixture) { :default_command }

      it 'returns group string' do
        expect(subject.default_command.summary_string).to eq 'get this (default)'
      end
    end
  end

  describe '#usage_string' do
    context 'when flags and commands are defined' do
      let(:fixture) { :mode_global_flags }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get [OPTIONS] COMMAND'
      end
    end

    context 'when only commands are defined' do
      let(:fixture) { :mode_commands }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get COMMAND'
      end
    end

    context 'when args and flags are defined' do
      let(:fixture) { :mode_args_and_flags }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get SOURCE [TARGET] [OPTIONS] [--] [PARAMS...]'
      end
    end

    context 'when only args are defined' do
      let(:fixture) { :mode_args }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get SOURCE [TARGET] [--] [PARAMS...]'
      end
    end

    context 'when only flags are defined' do
      let(:fixture) { :mode_flags }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get [OPTIONS] [--] [PARAMS...]'
      end

      context 'when it has a parent' do
        let(:fixture) { :flags_only_command }

        it 'returns the correct string' do
          expect(subject.usage_string).to eq 'git status [OPTIONS]'
        end
      end
    end

    context 'when nothing is defined' do
      let(:fixture) { :mode_empty }

      it 'returns the correct string' do
        expect(subject.usage_string).to eq 'get [--] [PARAMS...]'
      end

      context 'when it has a parent' do
        let(:fixture) { :git_status }

        it 'returns the correct string' do
          expect(subject.usage_string).to eq 'git status'
        end
      end
    end

    context 'when the command is set as default' do
      let(:fixture) { :default_command }

      it 'returns the correct string' do
        expect(subject.default_command.usage_string).to eq 'cli [get]'
      end
    end
  end

  describe '#user_file_path' do
    it 'returns the path to the user file' do
      expect(subject.user_file_path 'test.sh').to eq 'spec/tmp/src/test.sh'
    end

    context 'when the file argument does not end with .sh extension' do
      it 'returns the path with .sh appended' do
        expect(subject.user_file_path 'test').to eq 'spec/tmp/src/test.sh'
      end
    end

    context 'when partials_extension is set and the argument does not end with the selected extension' do
      before { Settings.partials_extension = 'bash' }
      after  { Settings.partials_extension = 'sh' }

      it 'returns the path with the selected extension appended' do
        expect(subject.user_file_path 'test').to eq 'spec/tmp/src/test.bash'
      end
    end
  end

  describe '#user_file_exist?' do
    before { FileUtils.mkdir_p 'spec/tmp/src' }

    context 'when the file exists in the user source path' do
      before { FileUtils.touch 'spec/tmp/src/test.sh' }

      it 'returns true' do
        expect(subject.user_file_exist?('test')).to be true
      end
    end

    context 'when the file does not in the user source path' do
      before { FileUtils.rm_f 'spec/tmp/src/test.sh' }

      it 'returns false' do
        expect(subject.user_file_exist?('test')).to be false
      end
    end
  end
end
