require 'spec_helper'

describe Library do
  subject { LibrarySource.new.libraries[name] }

  let(:name) { :colors }
  let(:lib_dir) { 'lib/bashly/libraries/colors' }

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
      let(:name) { :completions }

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
      before { subject.config['post_install_message'] = 'the message' }
      after { subject.config.delete 'post_install_message' }

      it 'returns the message' do
        expect(subject.post_install_message).to eq 'the message'
      end
    end

    context 'when the library has a custom handler' do
      let(:name) { :completions_yaml }

      before { reset_tmp_dir example: 'minimal' }

      it 'returns the message form the handler' do
        expect(subject.post_install_message).to include 'completely'
      end
    end
  end
end
