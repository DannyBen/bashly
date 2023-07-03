require 'spec_helper'

describe String do
  describe '#sanitize_for_print' do
    subject { %[this is\na "new line"] }

    it 'escapes newlines and quotes' do
      expect(subject.sanitize_for_print).to eq 'this is\\na \"new line\"'
    end
  end

  describe '#indent' do
    subject { 'hello' }

    it 'prepends the string with spaces' do
      expect(subject.indent(3)).to eq '   hello'
    end

    context 'when offset is 0' do
      it 'returns the string as is' do
        expect(subject.indent(0)).to eq subject
      end
    end
  end

  describe '#wrap' do
    subject { 'a long line of text that is going to be wrapped, fingers crossed!' }

    it 'wraps the string to the specified length' do
      expect(subject.wrap(30)).to eq "a long line of text that is\ngoing to be wrapped, fingers\ncrossed!"
    end

    # GH-79
    context 'with an uninterrupted string' do
      subject { 'a long line of text with a nice uninterrupted-string-like-a-url-for-example' }

      it 'does not break the uninterrupted portion' do
        expect(subject.wrap(30)).to eq "a long line of text with a\nnice\nuninterrupted-string-like-a-url-for-example"
      end
    end
  end

  describe '#to_underscore' do
    subject { 'Some String' }

    it 'does not mutate the source' do
      subject.to_underscore
      expect(subject).to eq 'Some String'
    end

    context 'with CamelCased argument' do
      subject { 'NotCamelCase' }

      it 'returns its snake_case version' do
        expect(subject.to_underscore).to eq 'not_camel_case'
      end
    end

    context 'with any string with spaces and hyphens' do
      subject { 'in any-case' }

      it 'returns its snake_case version' do
        expect(subject.to_underscore).to eq 'in_any_case'
      end
    end
  end

  describe '#to_path' do
    subject { 'Some Simple String' }

    it 'does not mutate the source' do
      subject.to_path
      expect(subject).to eq 'Some Simple String'
    end

    it 'returns it with spaces replaced as / and downcased' do
      expect(subject.to_path).to eq 'some/simple/string'
    end
  end

  describe '#lint' do
    context 'with a string that contains multiple consecutive newlines' do
      subject { "one\n  two\n  \n    three\n \n \nfour\n\n\n\n" }

      it 'replaces two or more newlines with two newlines' do
        expect(subject.lint).to eq "one\n  two\n\n    three\n\nfour\n\n"
      end
    end

    context 'with a string that contains double-hash comments' do
      subject { "this is important\n## SECRET\n  ## ANOTHER SECRET\n  also important\n" }

      it 'removes these comments' do
        expect(subject.lint).to eq "this is important\n  also important\n"
      end
    end
  end

  describe '#expand_tabs' do
    subject { "start\n  indented\n    indented more\nend" }

    let(:expected) { "start\n\tindented\n\t\tindented more\nend" }

    it 'replaces double leading spaces with tabs' do
      expect(subject.expand_tabs).to eq expected
    end

    context 'with an explicit tab stop of 4' do
      subject { "start\n    indented\n        indented more\nend" }

      it 'replaces each 4 spaces with a tab' do
        expect(subject.expand_tabs(4)).to eq expected
      end
    end
  end

  describe '#remove_front_matter' do
    context 'with a string that does not have front matter' do
      subject { "this is a\nsample script" }

      it 'returns it as is' do
        expect(subject.remove_front_matter).to eq subject
      end
    end

    context 'with a string that contains front matter' do
      subject { "#{front_matter}\n---\n#{rest}" }

      let(:front_matter) { 'this is the front matter' }
      let(:rest) { "this is\nthe script" }

      it 'returns the string without the front matter' do
        expect(subject.remove_front_matter).to eq rest
      end
    end

    context 'with a string that contains front matter with a leading separator' do
      subject { "---\n#{front_matter}\n---\n#{rest}" }

      let(:front_matter) { 'this is the front matter' }
      let(:rest) { "this is\nthe script" }

      it 'returns the string without the front matter' do
        expect(subject.remove_front_matter).to eq rest
      end
    end
  end

  describe '#color' do
    subject { 'color me' }

    context 'with no matching marker in the settings' do
      it 'returns the string as is' do
        expect(subject.color :no_such_marker).to eq subject
      end
    end

    context 'with a matching marker in the settings' do
      before { Settings.usage_colors = { 'some_marker' => 'some_color' } }
      after { Settings.usage_colors = {} }

      it 'returns the string wrapped in the requested function' do
        expect(subject.color :some_marker).to eq %[$(some_color "#{subject}")]
      end

      context 'when the string ends with spaces (for indentation)' do
        subject { 'color me   ' }

        it 'appends the spaces outside the function' do
          expect(subject.color :some_marker).to eq %[$(some_color "color me")   ]
        end
      end
    end
  end
end
