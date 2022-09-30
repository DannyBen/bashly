# Bashly Examples

Each of these examples demonstrates one aspect or feature of bashly.

## Basic use

- [minimal](minimal#readme) - the most basic "hello world" example
- [commands](commands#readme) - a script with sub-commands
- [commands-nested](commands-nested#readme) - a script with nested sub-commands

## Basic features

- [command-default](command-default#readme) - configuring a default command
- [command-aliases](command-aliases#readme) - allowing a command to be called with multiple names
- [dependencies](dependencies#readme) - halting script execution unless certain dependencies are installed
- [environment-variables](environment-variables#readme) - halting script execution unless certain environment variables are set
- [default-values](default-values#readme) - arguments and flags with default values
- [minus-v](minus-v#readme) - using `-v` and `-h` in your script
- [multiline](multiline#readme) - help messages with multiple lines

## Advanced configuration features

- [catch-all](catch-all#readme) - a command that can receive an arbitrary number of arguments
- [catch-all-advanced](catch-all-advanced#readme) - another example for the `catch_all` option
- [catch-all-stdin](catch-all-stdin#readme) - combining `catch_all` with `stdin` to read multiple files
- [extensible](extensible#readme) - letting your script's users extend the script
- [extensible-delegate](extensible-delegate#readme) - extending your script by delegating commands to an external executable
- [whitelist](whitelist#readme) - arguments and flags with a predefined allowed list of values
- [repeatable-arg](repeatable-arg#readme) - allowing arguments to be provided multiple times
- [repeatable-flag](repeatable-flag#readme) - allowing flags to be provided multiple times
- [conflicts](conflicts#readme) - defining mutually exclusive flags
- [command-private](command-private#readme) - hiding commands from the command list
- [stdin](stdin#readme) - reading input from stdin
- [filters](filters#readme) - preventing commands from running unless custom conditions are met
- [commands-expose](commands-expose#readme) - showing sub-commands in the parent's help

## Customization

- [command-groups](command-groups#readme) - grouping sub-commands in logical sections
- [custom-strings](custom-strings#readme) - configuring the script's error and usage texts
- [custom-includes](custom-includes#readme) - adding and organizing your custom functions
- [custom-script-header](custom-script-header#readme) - configuring a different script header
- [footer](footer#readme) - adding a footer to the help message
- [command-filenames](command-filenames#readme) - configuring paths for your source scripts
- [split-config](split-config#readme) - splitting your `bashly.yml` into several smaller files

## Real-world-like examples

- [docker-like](docker-like#readme) - a sample script with deep commands (like `docker container run`)
- [git-like](git-like#readme) - a sample script with sub-commands similar to git

## Bashly library features

- [config-ini](config-ini#readme) - using the config (INI) functions
- [colors](colors#readme) - using the color print feature
- [yaml](yaml#readme) - using the YAML reading functions
- [completions](completions#readme) - adding bash completion functionality
- [validations](validations#readme) - adding argument validation functions

## Other Examples

- [heredoc](heredoc#readme) - using heredoc strings
- [heredoc-alt](heredoc-alt#readme) - using heredoc strings in the lib directory
- [settings](settings#readme) - using the `settings.yml` file to adjust bashly's behavior
- [help-command](help-command#readme) - adding a help command to your script
