require 'spec_helper'

describe Script::Command do
  fixtures = load_fixture 'script/commands'

  subject { described_class.new fixtures[fixture] }

  let(:fixture) { :completions_simple }

  describe '#completion_data' do
    it 'returns a data structure for completely' do
      expect(subject.completion_data.to_yaml).to match_approval('completions/simple')
    end
  end

  describe '#completion_function' do
    it 'returns a bash completion script wrapped in a function' do
      expect(subject.completion_function('custom_name'))
        .to match_approval('completions/function')
    end
  end

  context 'with a more complex command' do
    let(:fixture) { :completions_advanced }

    describe '#completion_data' do
      it 'returns a data structure for completely' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/advanced')
      end
    end

    describe '#completion_script' do
      it 'returns a bash completion script' do
        expect(subject.completion_script)
          .to match_approval('completions/script')
      end
    end
  end

  context 'with a command that uses whitelist args' do
    let(:fixture) { :completions_whitelist }

    describe '#completion_data' do
      it 'returns a data structure that includes thw whitelist' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/whitelist')
      end
    end
  end

  context 'with a command that has nested command aliases' do
    let(:fixture) { :nested_aliases }

    describe '#completion_data' do
      it 'returns a data structure that includes all command full names' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/nested_aliases')
      end
    end
  end

  context 'with a command that has global flags on the root command' do
    let(:fixture) { :completions_global_flags_root }

    describe '#completion_data' do
      it 'returns a data structure that includes all command full names' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/completion_global_flags_root')
      end
    end
  end

  context 'with a command that has global flags on a nested command' do
    let(:fixture) { :completions_global_flags_nested }

    describe '#completion_data' do
      it 'returns a data structure that includes all command full names' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/completion_global_flags_nested')
      end
    end
  end

  context 'with a command that has global flags on the root and a nested command' do
    let(:fixture) { :completions_global_flags }

    describe '#completion_data' do
      it 'returns a data structure that includes all command full names' do
        expect(subject.completion_data.to_yaml)
          .to match_approval('completions/completion_global_flags')
      end
    end
  end
end
