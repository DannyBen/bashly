require 'spec_helper'

describe Settings do
  subject { described_class }

  describe 'standard value' do
    it 'returns a predefined default value' do
      expect(subject.tab_indent).to be false
    end

    context 'when its corresponding env var is set' do
      original_value = ENV['BASHLY_TAB_INDENT']

      before { described_class.tab_indent = nil }
      after { ENV['BASHLY_TAB_INDENT'] = original_value }

      it 'returns true when the env var is truthy' do
        %w[1 true yes].each do |value|
          ENV['BASHLY_TAB_INDENT'] = value
          expect(subject.tab_indent).to be true
        end
      end

      it 'returns false when the env var is falsy' do
        %w[0 false no].each do |value|
          ENV['BASHLY_TAB_INDENT'] = value
          expect(subject.tab_indent).to be false
        end
      end

      it 'returns the env var value itself otherwise' do
        ENV['BASHLY_TAB_INDENT'] = 'anything at all'
        expect(subject.tab_indent).to eq ENV['BASHLY_TAB_INDENT']
      end
    end
  end

  describe '::env' do
    it 'returns :development by default' do
      expect(subject.env).to eq :development
    end
  end

  describe '::production?' do
    it 'returns false by default' do
      expect(subject.production?).to be false
    end

    context 'when env == :production' do
      before { subject.env = :production }
      after { subject.env = nil }

      it 'returns true' do
        expect(subject.production?).to be true
      end
    end
  end

  describe 'strict_string' do
    original_value = described_class.strict

    after { subject.strict = original_value }

    context 'when strict is true' do
      before { subject.strict = true }

      it 'returns "set -euo pipefail"' do
        expect(subject.strict_string).to eq 'set -euo pipefail'
      end
    end

    context 'when strict is false' do
      before { subject.strict = false }

      it 'returns "set -e"' do
        expect(subject.strict_string).to eq 'set -e'
      end
    end

    context 'when strict is string' do
      before { subject.strict = 'set -o pipefail' }

      it 'returns the string as is' do
        expect(subject.strict_string).to eq 'set -o pipefail'
      end
    end
  end
end
