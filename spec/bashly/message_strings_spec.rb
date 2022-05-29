require 'spec_helper'

describe MessageStrings do
  describe '[]' do
    it "returns a default string for use in the generated bash" do
      expect(subject[:usage]).to eq "Usage:"
    end
  end

  context "when there is an override user configuration file" do
    let(:config_template) { "examples/custom-strings/src/bashly-strings.yml" }
    let(:userspace) { Settings.source_dir }

    before do
      reset_tmp_dir create_src: true
      cp config_template, userspace
    end

    after do
      reset_tmp_dir
    end

    it "returns values from the user config, falling back to defaults" do
      expect(subject[:usage]).to eq "== Usage ==\\n"
    end
  end
end
