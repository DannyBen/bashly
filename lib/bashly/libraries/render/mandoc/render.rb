# render script - mandoc
require 'gtx'

# Load the GTX template
template = "#{source}/mandoc.gtx"
gtx = GTX.load_file template

# Define a reusable code block for rendering a man page for a command
save_manpage = lambda { |command|
  mdfile = "#{target}/#{command.full_name.tr(' ', '-')}.md"
  manfile = "#{target}/#{command.full_name.tr(' ', '-')}.1"
  save mdfile, gtx.parse(command)

  # The pandoc command that creates a manpage from markdown
  cmd = %[pandoc -f markdown-smart -s --to man "#{mdfile}" > "#{manfile}"]
  success = system cmd
  raise "Failed running pandoc\nMake sure the following command succeeds and try again:\n\n  #{cmd}" unless success

  say "g`saved` #{manfile}"
}

# Render the main command
save_manpage.call command

# Render all subcommands
command.deep_commands.reject(&:private).each do |subcommand|
  save_manpage.call subcommand
end

# Show one of the files if requested
if show
  file = "#{target}/#{show}"
  system "man #{file}" if File.exist?(file)
end
