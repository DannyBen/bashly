require 'spec_helper'

describe Script::Dependency do
  subject do
    options = load_fixture('script/commands')[fixture]
    Script::Command.new(options).dependencies.first
  end

  let(:fixture) { :dependencies }

  describe '::from_config' do
    context 'with an unrecognized configuration' do
      it 'returns an empty instahnce' do
        expect(described_class.from_config('curl', 1)).to be_a described_class
      end
    end
  end

  describe '#label' do
    context 'when initialized with a string' do
      it 'returns the string' do
        expect(subject.label).to eq 'curl'
      end
    end

    context 'when initialized with a command => help hash' do
      let(:fixture) { :dependencies_simple_hash }

      it 'returns the command' do
        expect(subject.label).to eq 'curl'
      end
    end

    context 'when initialized with a label => config hash' do
      let(:fixture) { :dependencies_full_hash }

      it 'returns the label' do
        expect(subject.label).to eq 'http_client'
      end
    end
  end

  describe '#commands' do
    context 'when initialized with a string' do
      it 'returns an array with that string as its only element' do
        expect(subject.commands).to eq ['curl']
      end
    end

    context 'when initialized with a command => help hash' do
      let(:fixture) { :dependencies_simple_hash }

      it 'returns an array with the command as its only element' do
        expect(subject.commands).to eq ['curl']
      end
    end

    context 'when initialized with a label => config hash' do
      let(:fixture) { :dependencies_full_hash }

      it 'returns the commands provided by the config' do
        expect(subject.commands).to match_array %w[curl wget]
      end
    end
  end

  describe '#help' do
    context 'when initialized with a string' do
      it 'returns nil' do
        expect(subject.help).to be_nil
      end
    end

    context 'when initialized with a command => help hash' do
      let(:fixture) { :dependencies_simple_hash }

      it 'returns the provided help' do
        expect(subject.help).to eq 'Please install curl'
      end
    end

    context 'when initialized with a label => config hash' do
      let(:fixture) { :dependencies_full_hash }

      it 'returns the help provided by the config' do
        expect(subject.help).to eq 'Please install curl or wget'
      end
    end
  end

  describe '#name' do
    context 'when there is only one command' do
      it 'returns it' do
        expect(subject.name).to eq 'curl'
      end
    end

    context 'when there are more than one commands' do
      let(:fixture) { :dependencies_full_hash }

      it 'returns a string suitable for the error message' do
        expect(subject.name).to eq 'http_client (curl/wget)'
      end
    end
  end
end
