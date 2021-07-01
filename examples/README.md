# Bashly Examples

Each of these examples demonstrates one aspect or feature of bashly.

## Basic use

- [minimal](minimal) - the most basic "hello world" example
- [commands](commands) - a script with sub-commands
- [commands-nested](commands-nested) - a script with nested sub-commands

## Basic features

- [command-default](command-default) - configuring a default command
- [dependencies](dependencies) - halting script execution unless certain dependencies are installed
- [environment-variables](environment-variables) - halting script execution unless certain environment variables are set
- [default-values](default-values) - arguments and flags with default values
- [minus-v](minus-v) - using `-v` and `-h` in your script
- [multiline](multiline) - help messages with multiple lines

## Advanced features

- [catch-all](catch-all) - a command that can receive an arbitrary number of arguments
- [catch-all-advanced](catch-all-advanced) - another example for the `catch_all` option
- [extensible](extensible) - letting your script's users extend the script
- [extensible-delegate](extensible-delegate) - extending your script by delegating commands to an external executable
- [whitelist](whitelist) - arguments and flags with a predefined allowed list of values

## Customization

- [command-groups](command-groups) - grouping sub-commands in logical sections
- [custom-strings](custom-strings) - configuring the script's error and usage texts
- [custom-includes](custom-includes) - adding library functions

## Real-world-like examples

- [docker-like](docker-like) - a sample script with deep commands (like `docker container run`)
- [git-like](git-like) - a sample script with sub-commands similar to git

## Bashly library features

- [config-ini](config-ini) - using the config (INI) functions
- [colors](colors) - using the color print feature
- [yaml](yaml) - using the YAML reading functions
