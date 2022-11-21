require 'spec_helper'

describe File do
  describe '::deep_write' do
    it 'creates parent directories and writes a file' do
      expect(FileUtils).to receive(:mkdir_p).with('some/path')
      expect(described_class).to receive(:write).with('some/path/file.txt', 'text')
      described_class.deep_write 'some/path/file.txt', 'text'
    end
  end
end
