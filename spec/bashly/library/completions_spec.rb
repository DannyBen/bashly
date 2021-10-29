require 'spec_helper'

describe Library::Completions do
  describe '#file_content' do
    it "raises a NotImplementedError" do
      expect { subject.content }.to raise_error(NotImplementedError)
    end
  end
end
