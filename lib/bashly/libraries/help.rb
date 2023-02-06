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

            g`commands`:
              g`- name`: m`help`
              g`  help`: m`Show help about a command`
              g`  args`:
                g`- name`: m`command`
                g`  help`: m`Help subject`

        MESSAGE
      end

    private

      def help_command
        asset_content('templates/lib/help_command.sh') % { name: command.name }
      end
    end
  end
end
