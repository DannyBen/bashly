require 'mister_bin'

module Bashly
  # The CLI class is used by the bashly binary and forwards incoming CLI
  # commands to the relevant Bashly::Commands class
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: Bashly::VERSION,
        header: 'Bashly - Bash CLI Generator',
        footer: "Help: m`bashly COMMAND --help`\nDocs: bu`https://bashly.dannyb.co`"

      runner.route 'init',             to: Commands::Init
      runner.route 'preview',          to: Commands::Preview
      runner.route 'validate',         to: Commands::Validate
      runner.route %w[generate build], to: Commands::Generate
      runner.route 'add',              to: Commands::Add
      runner.route 'doc',              to: Commands::Doc
      runner.route 'completions',      to: Commands::Completions
      runner.route 'render',           to: Commands::Render
      runner.route 'shell',            to: Commands::Shell unless ENV['BASHLY_SHELL']

      runner
    end
  end
end
