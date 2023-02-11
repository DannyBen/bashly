module Bashly
  module Commands
    class Add < Base
      help 'Add extra features and customization to your script'

      usage 'bashly add LIBRARY [ARGS...] [--force]'
      usage 'bashly add --list'
      usage 'bashly add (-h|--help)'

      option '-f --force', 'Overwrite existing files'
      option '-l --list', 'Show available libraries'

      attr_reader :skip_src_check

      def run
        if args['--list']
          show_list
        else
          add_lib args['LIBRARY']
        end
      end
      
    private

      def lib_source
        @lib_source ||= Bashly::LibrarySource.new
      end

      def show_list
        lib_source.config.each do |key, config|
          usage = key
          usage += " #{config['usage']}" if config['usage']
          say "g`bashly add #{usage}`"
          say word_wrap("  #{config['help']}")
          say ''
        end
      end

      def add_lib(name)
        library = lib_source.libraries[name.to_sym]
        raise "Unknown library: g`#{name}`\nRun m`bashly add --list` to see available libraries" unless library

        library.args = args['ARGS']
        @skip_src_check = lib_source.config.dig name, 'skip_src_check'

        files_created = 0
        library.files.each do |file|
          created = safe_write file[:path], file[:content]
          files_created += 1 if created
        end

        message = library.post_install_message
        say "\n#{message}" if message && files_created.positive?
      end

      def safe_write(path, content)
        if !skip_src_check && !Dir.exist?(Settings.source_dir)
          raise InitError, <<~ERROR
            Directory g`#{Settings.source_dir}` does not exist
            Run m`bashly init` first
          ERROR
        end

        if File.exist?(path) && !args['--force']
          say "b`skipped` #{path} (exists)"
          false

        else
          File.deep_write path, content
          say "g`created` #{path}"
          true

        end
      end
    end
  end
end
