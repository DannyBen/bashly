require 'mister_bin'

module Bashly
  # The CLI class is used by the bashly binary and forwards incoming CLI 
  # commands to the relevant Bashly::Commands class
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: Bashly::VERSION,
        header: "Bashly - Bash CLI Generator",
        footer: "Help: !txtpur!bashly COMMAND --help!txtrst!\nDocs: !undblu!https://bashly.dannyb.co"

      runner.route 'init',      to: Commands::Init
      runner.route 'preview',   to: Commands::Preview
      runner.route 'validate',  to: Commands::Validate
      runner.route 'generate',  to: Commands::Generate
      runner.route 'add',       to: Commands::Add

      runner
    end
  end

end
