# Bashly Examples

Each of these examples demonstrates one aspect or feature of bashly.

## Basic use

- [minimal](minimal#readme) - the most basic "hello world" example
- [commands](commands#readme) - a script with subcommands
- [commands-nested](commands-nested#readme) - a script with nested subcommands

## Basic features

- [command-default](command-default#readme) - configuring a default command
- [command-default-force](command-default-force#readme) - configuring a default command that runs instead of showing the usage text
- [command-aliases](command-aliases#readme) - allowing a command to be called with multiple names
- [command-examples](command-examples#readme) - configuring command examples
- [dependencies](dependencies#readme) - halting script execution unless certain dependencies are installed
- [dependencies-alt](dependencies-alt#readme) - halting script execution unless one of the required dependencies is installed
- [environment-variables](environment-variables#readme) - halting script execution unless certain environment variables are set
- [variables](variables#readme) - defining bash variables
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
- [reusable-flags](reusable-flags#readme) - reuse flag definition for multiple commands
- [conflicts](conflicts#readme) - defining mutually exclusive flags
- [needs](needs#readme) - defining flags that need other flags
- [command-private](command-private#readme) - hiding commands from the command list
- [private-reveal](private-reveal#readme) - allowing users to reveal private commands, flags or environment variables
- [stdin](stdin#readme) - reading input from stdin
- [filters](filters#readme) - preventing commands from running unless custom conditions are met
- [commands-expose](commands-expose#readme) - showing subcommands in the parent's help
- [key-value-pairs](key-value-pairs#readme) - parsing key=value arguments and flags
- [command-examples-on-error](command-examples-on-error#readme) - showing examples on error
- [internal-run](internal-run#readme) - calling other commands internally

## Customization

- [colors-usage](colors-usage#readme) - adding colors to the usage text
- [command-groups](command-groups#readme) - grouping subcommands in logical sections
- [custom-strings](custom-strings#readme) - configuring the script's error and usage texts
- [custom-includes](custom-includes#readme) - adding and organizing your custom functions
- [custom-script-header](custom-script-header#readme) - configuring a different script header
- [help-header-override](help-header-override#readme) - replacing the header of the help message
- [footer](footer#readme) - adding a footer to the help message
- [command-filenames](command-filenames#readme) - overriding filenames for your source scripts
- [command-paths](command-paths#readme) - configuring nested paths for your source scripts
- [command-function](command-function#readme) - configuring custom internal function names
- [split-config](split-config#readme) - splitting your `bashly.yml` into several smaller files

## Bashly library features

- [config](config#readme) - using the config library for easy access to INI files
- [ini](ini#readme) - using the ini library for direct, low level access to INI files
- [yaml](yaml#readme) - using the YAML reading functions
- [colors](colors#readme) - using the color print feature
- [completions](completions#readme) - adding bash completion functionality
- [validations](validations#readme) - adding validation functions for arguments, flags or environment variables
- [hooks](hooks#readme) - adding before/after hooks

## Real-world-like examples

- [docker-like](docker-like#readme) - a sample script with deep commands (like `docker container run`)
- [git-like](git-like#readme) - a sample script with subcommands similar to git

## Documentation generation

- [render-mandoc](render-mandoc#readme) - auto-generate man pages for your script
- [render-markdown](render-markdown#readme) - auto-generate markdown documentation for your script

## Other examples

- [settings](settings#readme) - using the `settings.yml` file to adjust bashly's behavior
- [help-command](help-command#readme) - adding a help command to your script
