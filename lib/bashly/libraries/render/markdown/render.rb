# render script - markdown
require 'gtx'

# for previewing only (not needed for rendering)
require 'tty-markdown'

# Load the GTX template
template = "#{source}/markdown.gtx"
gtx = GTX.load_file template

# Render the file for the main command
save "#{target}/index.md", gtx.parse(command)

# Render a file for each subcommand
command.deep_commands.reject(&:private).each do |subcommand|
  save "#{target}/#{subcommand.full_name}.md", gtx.parse(subcommand)
end

# Show one of the files if requested
if show
  file = "#{target}/#{show}"
  puts TTY::Markdown.parse_file(file) if File.exist?(file)
end
