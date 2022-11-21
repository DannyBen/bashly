require 'spec_helper'

describe Library do
  subject { described_class.new name, args }

  let(:name) { 'colors' }
  let(:args) { nil }
  let(:lib_dir) { 'lib/bashly/templates/lib' }

  describe '::exist?' do
    it 'returns true if the provided library name exists' do
      expect(described_class).to exist 'colors'
    end

    it 'returns false if the provided library name does not exist' do
      expect(described_class).not_to exist 'crypto_mining'
    end
  end

  describe '::config' do
    it 'returns the entire libraries configuration data' do
      expect(described_class.config).to be_a Hash
      expect(described_class.config.keys.to_yaml).to match_approval('library/config-keys')
    end
  end

  describe '#files' do
    it 'returns an array of hashes' do
      expect(subject.files).to be_an Array
      expect(subject.files.first).to be_a Hash
    end

    it 'returns the content and target paths of the library files' do
      matter = subject.files.first
      expect(matter.keys).to match_array %i[path content]
      expect(matter[:path]).to eq "#{Settings.target_dir}/src/lib/colors.sh"
      expect(matter[:content]).to eq File.read("#{lib_dir}/colors.sh")
    end

    context 'when the library has a custom handler' do
      let(:name) { 'completions' }

      before { reset_tmp_dir example: 'minimal' }

      it 'delegaes the request to a custom handler' do
        expect(subject.files).to be_an Array
        expect(subject.files.first).to be_a Hash
        expect(subject.files.first.keys).to match_array %i[path content]
      end
    end
  end

  describe '#post_install_message' do
    context 'when the library has no configured message' do
      it 'returns nil' do
        expect(subject.post_install_message).to be_nil
      end
    end

    context 'when the library has a configured message' do
      before { described_class.config['colors']['post_install_message'] = 'the message' }
      after { described_class.config['colors'].delete 'post_install_message' }

      it 'returns the message' do
        expect(subject.post_install_message).to eq 'the message'
      end
    end

    context 'when the library has a custom handler' do
      let(:name) { 'completions_yaml' }

      before { reset_tmp_dir example: 'minimal' }

      it 'returns the message form the handler' do
        expect(subject.post_install_message).to include 'completely'
      end
    end
  end
end
