require 'spec_helper'

describe Libraries::Base do
  describe '#files' do
    it "raises a NotImplementedError" do
      expect { subject.files }.to raise_error(NotImplementedError)
    end
  end

  describe '#post_install_message' do
    it "returns nil" do
      expect(subject.post_install_message).to be_nil
    end
  end
end
