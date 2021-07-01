# Bashly Examples

Each of these examples demonstrates one aspect or feature of bashly.

## Basic use

- [minimal](minimal#readme) - the most basic "hello world" example
- [commands](commands#readme) - a script with sub-commands
- [commands-nested](commands-nested#readme) - a script with nested sub-commands

## Basic features

- [command-default](command-default#readme) - configuring a default command
- [dependencies](dependencies#readme) - halting script execution unless certain dependencies are installed
- [environment-variables](environment-variables#readme) - halting script execution unless certain environment variables are set
- [default-values](default-values#readme) - arguments and flags with default values
- [minus-v](minus-v#readme) - using `-v` and `-h` in your script
- [multiline](multiline#readme) - help messages with multiple lines

## Advanced features

- [catch-all](catch-all#readme) - a command that can receive an arbitrary number of arguments
- [catch-all-advanced](catch-all-advanced#readme) - another example for the `catch_all` option
- [extensible](extensible#readme) - letting your script's users extend the script
- [extensible-delegate](extensible-delegate#readme) - extending your script by delegating commands to an external executable
- [whitelist](whitelist#readme) - arguments and flags with a predefined allowed list of values

## Customization

- [command-groups](command-groups#readme) - grouping sub-commands in logical sections
- [custom-strings](custom-strings#readme) - configuring the script's error and usage texts
- [custom-includes](custom-includes#readme) - adding library functions

## Real-world-like examples

- [docker-like](docker-like#readme) - a sample script with deep commands (like `docker container run`)
- [git-like](git-like#readme) - a sample script with sub-commands similar to git

## Bashly library features

- [config-ini](config-ini#readme) - using the config (INI) functions
- [colors](colors#readme) - using the color print feature
- [yaml](yaml#readme) - using the YAML reading functions
