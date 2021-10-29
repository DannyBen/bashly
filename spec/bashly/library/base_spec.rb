require 'spec_helper'

describe Library::Base do
  let(:lib_dir) { 'lib/bashly/templates/lib' }

  describe '#content' do
    it "raises a NotImplementedError" do
      expect { subject.content }.to raise_error(NotImplementedError)
    end
  end

  describe '#files' do
    it "raises a NotImplementedError" do
      expect { subject.files }.to raise_error(NotImplementedError)
    end

    context "when #content is a string representing a lib/file" do
      subject do
        Class.new(described_class) { def content; "colors.sh"; end }.new
      end
      
      it "returns an array of hashes" do
        expect(subject.files).to be_an Array
        expect(subject.files.first).to be_a Hash
      end

      it "returns the content and target paths of the library files" do
        matter = subject.files.first
        expect(matter.keys).to eq [:path, :content]
        expect(matter[:path]).to eq "#{Settings.target_dir}/src/lib/#{subject.content}"
        expect(matter[:content]).to eq File.read("#{lib_dir}/#{subject.content}")
      end
    end

    context "when #content is a string representing a lib/dir" do
      subject do
        Class.new(described_class) { def content = "validations" }.new
      end
      
      it "returns an array of hashes" do
        expect(subject.files).to be_an Array
        expect(subject.files.first).to be_a Hash
      end
      
      it "returns an array as big as the library folder" do
        expect(subject.files.count).to be > 1
        expect(subject.files.count).to eq Dir["#{lib_dir}/#{subject.content}/*.sh"].count
      end

      it "returns the content and target paths of the library files" do
        expect(subject.files.to_yaml).to match_approval 'library/base/dir'
      end
    end

    context "when #content is a hash" do
      subject do
        Class.new(described_class) { def content; { some: 'hash' }; end }.new
      end
      
      it "returns an array with the hash as its first and only element" do
        expect(subject.files).to be_an Array
        expect(subject.files.count).to eq 1
        expect(subject.files.first).to eq subject.content
      end
    end

    context "when #content is something else" do
      subject do
        Class.new(described_class) { def content; ["something else"]; end }.new
      end
      
      it "returns it as is" do
        expect(subject.files).to eq subject.content
      end
    end
  end

  describe '#post_install_message' do
    it "returns nil" do
      expect(subject.post_install_message).to be_nil
    end
  end
end
