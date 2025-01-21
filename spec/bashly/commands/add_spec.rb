describe Commands::Add do
  subject { described_class.new }

  let(:source_dir) { Settings.source_dir }
  let(:target_dir) { Settings.target_dir }

  describe 'add --help' do
    it 'shows long usage' do
      expect { subject.execute %w[add --help] }.to output_approval('cli/add/help')
    end
  end

  describe 'add' do
    it 'shows short usage' do
      expect { subject.execute %w[add] }.to output_approval('cli/add/usage')
    end
  end

  describe 'add --list' do
    it 'shows list of available libraries' do
      expect { subject.execute %w[add --list] }.to output_approval('cli/add/list')
    end

    context 'with --source path' do
      it 'shows the list from the specified path' do
        expect { subject.execute %w[add --source spec/fixtures/libraries --list] }
          .to output_approval('cli/add/list-path')
      end
    end
  end

  describe 'add unrecognized-library' do
    it 'raises an error' do
      expect { subject.execute %w[add no-such-lib] }.to raise_approval('cli/add/no-lib-error')
        .diff(5)
    end
  end

  describe 'add colors' do
    let(:lib_file) { "#{source_dir}/lib/colors.sh" }

    before { reset_tmp_dir create_src: true }

    it 'copies the colors.sh lib file to the user space' do
      expect { subject.execute %w[add colors] }.to output_approval('cli/add/colors')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add colors --quiet' do
    let(:lib_file) { "#{source_dir}/lib/colors.sh" }

    before { reset_tmp_dir create_src: true }

    it 'does not show the post-install message' do
      expect { subject.execute %w[add colors --quiet] }.to output_approval('cli/add/colors-quiet')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add completions' do
    before { reset_tmp_dir init: true }

    it 'creates lib/send_completions.sh' do
      expect { subject.execute %w[add completions] }.to output_approval('cli/add/comp-function')
      expect(File.read("#{source_dir}/lib/send_completions.sh")).to match_approval('cli/add/comp-function-file')
    end
  end

  describe 'add completions_script' do
    it 'creates completions.bash' do
      expect { subject.execute %w[add completions_script] }.to output_approval('cli/add/comp-script')
      expect(File.read("#{target_dir}/completions.bash")).to match_approval('cli/add/comp-script-file')
    end
  end

  describe 'add completions_yaml' do
    it 'creates completions.yml' do
      expect { subject.execute %w[add completions_yaml] }.to output_approval('cli/add/comp-yaml')
      expect(File.read("#{target_dir}/completions.yml")).to match_approval('cli/add/comp-yaml-file')
    end
  end

  describe 'add config' do
    let(:lib_file) { "#{source_dir}/lib/config.sh" }

    before { reset_tmp_dir create_src: true }

    it 'copies the config.sh lib file to the user space' do
      expect { subject.execute %w[add config] }.to output_approval('cli/add/config')
      expect(File).to exist(lib_file)
    end
  end

  describe 'help' do
    let(:help_command_file) { "#{source_dir}/help_command.sh" }

    before { reset_tmp_dir init: true }

    it 'copies the help_command.sh lib file to the user space' do
      expect { subject.execute %w[add help] }.to output_approval('cli/add/help_command')
      expect(File).to exist(help_command_file)
    end
  end

  describe 'add hooks' do
    let(:before_hook_file) { "#{source_dir}/before.sh" }
    let(:after_hook_file) { "#{source_dir}/after.sh" }

    before { reset_tmp_dir init: true }

    it 'copies before.sh and after.sh to the user space' do
      expect { subject.execute %w[add hooks] }.to output_approval('cli/add/hooks_command')
      expect(File).to exist(before_hook_file)
      expect(File).to exist(after_hook_file)
    end
  end

  describe 'add lib' do
    let(:lib_file) { "#{source_dir}/lib/sample_function.sh" }

    before { reset_tmp_dir create_src: true }

    it 'copies a sample function to the user space under lib directory' do
      expect { subject.execute %w[add lib] }.to output_approval('cli/add/lib')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add settings' do
    let(:settings_file) { "#{target_dir}/settings.yml" }
    let(:template_file) { 'lib/bashly/libraries/settings/settings.yml' }

    before { reset_tmp_dir }

    it 'copies the settings file to the current directory' do
      expect do
        Dir.chdir target_dir do
          subject.execute %w[add settings]
        end
      end.to output_approval('cli/add/settings')
      expect(File).to exist(settings_file)
      expect(File.read(settings_file)).to eq File.read(template_file)
    end

    context 'when the file exists' do
      it 'skips copying it' do
        expect do
          Dir.chdir target_dir do
            subject.execute %w[add settings]
            subject.execute %w[add settings]
          end
        end.to output_approval('cli/add/settings-exist')
      end
    end
  end

  describe 'add strings' do
    let(:strings_file) { "#{source_dir}/bashly-strings.yml" }

    before { reset_tmp_dir create_src: true }

    it 'copies the strings configuration to the user space' do
      expect { subject.execute %w[add strings] }.to output_approval('cli/add/strings')
      expect(File).to exist(strings_file)
    end

    context 'when the source directory does not exist' do
      before { reset_tmp_dir }

      it 'raises an error' do
        expect { subject.execute %w[add strings] }.to raise_error(InitError, /does not exist/)
      end
    end

    context 'when the file exists' do
      it 'skips copying it' do
        expect { subject.execute %w[add strings] }.to output_approval('cli/add/strings')
        expect { subject.execute %w[add strings] }.to output_approval('cli/add/strings-exist')
      end
    end
  end

  describe 'add test' do
    let(:lib_file) { "#{target_dir}/test/approvals.bash" }

    before { reset_tmp_dir create_src: true }

    it 'copies the test folder to the user space' do
      expect { subject.execute %w[add test] }.to output_approval('cli/add/test')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add validations' do
    let(:lib_file) { "#{source_dir}/lib/validations/validate_integer.sh" }

    before { reset_tmp_dir create_src: true }

    it 'copies the validation lib folder to the user space' do
      expect { subject.execute %w[add validations] }.to output_approval('cli/add/validations')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add yaml' do
    let(:lib_file) { "#{source_dir}/lib/yaml.sh" }

    before { reset_tmp_dir create_src: true }

    it 'copies the yaml.sh lib file to the user space' do
      expect { subject.execute %w[add yaml] }.to output_approval('cli/add/yaml')
      expect(File).to exist(lib_file)
    end
  end

  describe 'add --source PATH LIBRARY' do
    before { reset_tmp_dir create_src: true }

    it 'properly installs the library' do
      expect { subject.execute %w[add --source spec/fixtures/libraries database] }
        .to output_approval('cli/add/from-external-path')
    end
  end

  describe 'add --source github:URI LIBRARY' do
    before { reset_tmp_dir create_src: true }

    it 'properly installs the library' do
      expect { subject.execute %w[add --source github:dannyben/bashly//spec/fixtures/libraries database] }
        .to output_approval('cli/add/from-github')
    end
  end
end
