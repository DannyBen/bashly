# render script - mandoc
#
# You may set the environment variable PREVIEW to the full command you wich 
# to preview while generating. For example:
#
#   PREVIEW="cli download" bashly render :mandoc docs --watch
#
# Alternatively, view any of the man pages with man:
#
#   man docs/cli.1
#

# Load the GTX template
template = "#{source}/mandoc.gtx"
gtx = GTX.load_file template

# Define a reusable code block for rendering a man page for a command
save_manpage = lambda { |command|
  mdfile = "#{target}/#{command.full_name.tr(' ', '-')}.md"
  manfile = "#{target}/#{command.full_name.tr(' ', '-')}.1"
  save mdfile, gtx.parse(command)

  cmd = %[pandoc -f markdown-smart -s --to man "#{mdfile}" > "#{manfile}"]

  success = system cmd
  raise "Failed running pandoc\nMake sure the following command succeeds and try again:\n\n  #{cmd}" unless success

  say "g`saved` #{manfile}"

  system %[man "#{manfile}"] if ENV['PREVIEW'] == command.full_name
}

# Render the main command
save_manpage.call command

# Render all subcommands
command.deep_commands.reject(&:private).each do |subcommand|
  save_manpage.call subcommand
end
