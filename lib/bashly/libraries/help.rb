module Bashly
  module Libraries
    class Help < Base
      include AssetHelper

      def files
        [
          {
            path:    "#{Settings.source_dir}/help_command.#{Settings.partials_extension}",
            content: help_command,
          },
        ]
      end

      def post_install_message
        <<~MESSAGE
          Add this as a command to your bashly.yml:

            !txtgrn!commands:
              !txtgrn!- name: !txtpur!help
              !txtgrn!  help: !txtpur!Show help about a command
              !txtgrn!  args:
                !txtgrn!- name: !txtpur!command
                !txtgrn!  help: !txtpur!Help subject

        MESSAGE
      end

    private

      def help_command
        asset_content('templates/help/help_command.sh') % { name: command.name }
      end
    end
  end
end
