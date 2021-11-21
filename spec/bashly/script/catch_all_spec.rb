require 'spec_helper'

describe Script::CatchAll do
  let(:fixture) { :basic_command }

  subject do
    options = load_fixture('script/commands')[fixture]
    Script::Command.new(options).catch_all
  end

  describe '#label' do
    context "when catch_all is disabled" do
      it "returns nil" do
        expect(subject.label).to be_nil
      end
    end

    context "when catch_all is a string" do
      let(:fixture) { :catch_all_string }

      it "returns an uppercase version of it" do
        expect(subject.label).to eq "EXTRA_PARAMS..."
      end
    end

    context "when catch_all is set" do
      let(:fixture) { :catch_all_hash }

      it "returns an uppercase version of it" do
        expect(subject.label).to eq "ADDITIONAL_PARAMS..."
      end
    end

    context "in other cases" do
      let(:fixture) { :catch_all }

      it "returns '...'" do
        expect(subject.label).to eq "..."
      end
    end
  end
  
  describe '#help' do
    context "when catch_all is disabled" do
      it "returns nil" do
        expect(subject.help).to be_nil
      end
    end

    context "when catch_all is a hash" do
      let(:fixture) { :catch_all_hash }

      it "returns an uppercase version of its label" do
        expect(subject.help).to eq "Any additional argument or flag"
      end
    end

    context "in other cases" do
      let(:fixture) { :catch_all_string }

      it "returns nil" do
        expect(subject.help).to be_nil
      end
    end
  end

  describe '#required?' do
    context "when catch_all is disabled" do
      it "returns false" do
        expect(subject.required?).to be false
      end
    end

    context "when catch_all['required'] is true" do
      let(:fixture) { :catch_all_hash }

      it "returns true" do
        expect(subject.required?).to be true
      end
    end

    context "in other cases" do
      let(:fixture) { :catch_all_string }

      it "returns false" do
        expect(subject.required?).to be false
      end
    end
  end

  describe '#usage_string' do
    context "when catch_all is disabled" do
      it "returns nil" do
        expect(subject.usage_string).to be_nil
      end
    end

    context "when catch_all['required'] is true" do
      let(:fixture) { :catch_all_hash }

      it "returns a usage help without []" do
        expect(subject.usage_string).to eq "ADDITIONAL_PARAMS..."
      end
    end

    context "when catch_all['required'] is false" do
      let(:fixture) { :catch_all_string }

      it "returns a usage help with []" do
        expect(subject.usage_string).to eq "[EXTRA_PARAMS...]"
      end
    end

    context "when catch_all is true" do
      let(:fixture) { :catch_all }

      it "returns [...]" do
        expect(subject.usage_string).to eq "[...]"
      end
    end
  end

end
