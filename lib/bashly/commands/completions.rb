module Bashly
  module Commands
    class Completions < Base
      summary 'Install bash completions for bashly itself'
      help 'Display the bash completions script or install it directly to your bash completions directory'

      usage 'bashly completions [--install]'
      usage 'bashly completions (-h|--help)'

      option '-i --install', 'Install the completions script to your bash completions directory'

      def run
        if args['--install']
          install_completions
        else
          puts script
        end
      end

      def installer
        @installer ||= Completely::Installer.new program: 'bashly', script_path: script_path
      end

    private

      def install_completions
        success = installer.install force: true
        raise Error, "Failed running command:\nnb`#{installer.command_string}`" unless success

        say 'Completions installed.'
        say "Source: m`#{installer.script_path}`"
        say "Target: m`#{installer.target_path}`"
        say 'Restart your session for the changes to take effect'
      end

      def script_path
        @script_path ||= asset('completions/bashly-completions.bash')
      end

      def script
        @script ||= asset_content('completions/bashly-completions.bash')
      end
    end
  end
end
