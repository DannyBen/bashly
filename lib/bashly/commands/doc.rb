module Bashly
  module Commands
    class Doc < Base
      summary 'Show bashly reference documentation'
      help 'This command displays bite-sized help for all the bashly configuration options in the terminal.'

      usage 'bashly doc [SEARCH] [--index]'
      usage 'bashly doc (-h|--help)'

      option "-i --index", "Show option keys only"
      param 'SEARCH', 'Search for options that match this text'

      example 'bashly doc command'
      example 'bashly doc command.flags'
      example 'bashly doc catch_all'

      def run
        if args['--index']
          puts data.keys
        else
          show
        end
      end

    private

      def show
        data.each do |key, info|
          show_key key
          show_help info['help']
          show_example info['example'] if info['example']
          show_url info['url'] if info['url']
        end
      end

      def show_key(key)
        say "!txtgrn!#{key}"
        say ''
      end

      def show_url(url)
        say "  See !undblu!#{url}"
        say ''
      end

      def show_example(example)
        example = word_wrap "    #{example}"
        example.gsub!(/^(\s*- )?(\s*\w+):/, '\1!txtblu!\2!txtrst!:')
        example.gsub!(/^(\s*\- )/, '!txtylw!\1!txtrst!')
        example.gsub!(/^(\s*#.+)/, '!txtpur!\1!txtrst!')
        say example
        say ''
      end

      def show_help(help)
        help = word_wrap "  #{help}"
        help.gsub!(/`([^`]+)`/, '!txtgrn!\1!txtrst!')
        say help
        say ''
      end

      def data
        return raw_data unless args['SEARCH']
        
        result = raw_data.select { |k, v| k. == args['SEARCH'] }
        return result if result.any?

        result = raw_data.select { |k, v| k.include? args['SEARCH'] }
        return result if result.any?

        say! "!txtred!No match"
        exit 1
      end

      def raw_data
        @raw_data ||= begin
          result = {}
          Dir["#{docs_dir}/*.yml"].sort.each do |path|
            result.merge! YAML.load_file(path)
          end
          result
        end
      end

      def docs_dir
        @docs_dir ||= File.expand_path "../docs", __dir__
      end
    end
  end
end
