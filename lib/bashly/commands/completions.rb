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
          show_completions
        end
      end

    private

      def install_completions
        raise Error, 'Cannot find completions directory' unless compdir

        target = "#{compdir}/bashly"

        say "Installing completions to m`#{target}`"
        command = %[cp "#{completions_path}" "#{target}"]
        command = "sudo #{command}" unless root_user?
        system command

        say 'Restart your session for the changes to take effect.'
      end

      def show_completions
        puts completions_script
      end

      def completions_path
        @completions_path ||= asset('completions/bashly-completions.bash')
      end

      def completions_script
        @completions_script ||= asset_content('completions/bashly-completions.bash')
      end

      def compdir
        @compdir ||= compdir!
      end

      def compdir!
        compdir_candidates.each { |dir| return dir if Dir.exist? dir }
        nil
      end

      def compdir_candidates
        @compdir_candidates ||= [
          '/usr/share/bash-completion/completions',
          '/usr/local/etc/bash_completion.d',
        ]
      end

      def root_user?
        Process.uid.zero?
      end
    end
  end
end
