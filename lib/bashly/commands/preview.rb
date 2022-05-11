module Bashly
  module Commands
    class Preview < Base
      help "Generate the bash script to STDOUT"

      usage "bashly preview"
      usage "bashly preview (-h|--help)"

      environment "BASHLY_SOURCE_DIR", "The path containing the bashly configuration and source files [default: src]"

      def run
        with_valid_config do
          command = Script::Command.new config
          script = Script::Wrapper.new command
          puts script.code
        end
      end
    end
  end
end
