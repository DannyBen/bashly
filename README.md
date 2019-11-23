<div align='center'>
<img src='logo.svg' width=280>

Bashly - Bash CLI Framework and Generator
==================================================

Create beautiful bash scripts from simple YAML configuration

[![Gem Version](https://badge.fury.io/rb/bashly.svg)](https://badge.fury.io/rb/bashly)
[![Build Status](https://travis-ci.com/DannyBen/bashly.svg?branch=master)](https://travis-ci.com/DannyBen/bashly)
[![Maintainability](https://api.codeclimate.com/v1/badges/8cf89047e50ca601e431/maintainability)](https://codeclimate.com/github/DannyBen/bashly/maintainability)

---

![demo](demo/cast.svg)

</div>

---

Installation
--------------------------------------------------

```shell
$ gem install bashly
```


What is Bashly
--------------------------------------------------

Bashly is a command line application (written in Ruby) that lets you generate
feature-rich bash command line tools.

The design intention is to let you focus on your specific code, without 
worrying about command line argument parsing, usage texts, error messages
and other functions that are usually handled by a framework in any other
programming language.

Bahsly is responsible for:

- Generating **usage texts** and help screens, showing your tool's arguments, 
  flags and subcommands (works for subcommands also).
- Parsing the user's command line and extracting:
  - Optional or required **positional arguments**.
  - Optional or required **option flags** (with or without flag arguments).
  - **Subcommands**.
  - Standard flags (like **--help** and **--version**).
- Providing you with a place to input your code for each of the functions 
  your tool performs, and merging it back to the final script.
- Providing you with additional (optional) framework-style, standard
  library functions:
  - **Color output**.
  - **Config file management** (INI format).

Usage
--------------------------------------------------

In an empty directory, create a sample configuration file by running

```shell
$ bashly init
# or, to generate a simpler configuration:
$ bashly init --minimal
```

This will create a sample `src/bashly.yml` file.
You can edit this file to specify which arguments, flags and subcommands you
need in your bash script.

Then, generate an initial bash script and function placeholder scripts by
running

```shell
$ bashly generate
```

This will:

1. Create the bash executable script.
2. Create files for you to edit in the `src` folder.

Finally, edit the files in the `src` folder. Each of your script's commands
get their own file. Once you edit, run `bashly generate` again to merge the
content from your functions back into the script.


Examples
--------------------------------------------------

The `bashly.yml` file can be set up to generate two types of scripts:

1. Script with subcommands (for example, like `docker` or `git`).
2. Script without subcommands (for example, like `ls`)

This is detected automatically by the contents of the configuration: If it
contains a `commands` definition, it will generate a script with subcommands.


### Sample configuraiton for a script without subcommands

- Generate this script by running `bashly generate --minimal`
- [See the initial sample bashly.yml file](examples/minimal/src/bashly.yml)
- [See the generated bash script](examples/minimal/download)

### Sample configuraiton for a script with subcommands

- Generate this script by running `bashly generate`
- [See the initial sample bashly.yml file](examples/subcommands/src/bashly.yml)
- [See the generated bash script](examples/subcommands/cli)


See the [examples](examples) folder for more examples.



Configuration Reference
--------------------------------------------------

### Command options

Unless otherwise specified, these definitiona can be used for both the root
command and subcommands (under the `commands` definition).

```yaml
# The name of the script or subcommand
name: myscript

# An additional, optional name - usually used to denote a one letter 
# variation of the command name
# Applicable only in subcommands
short: m

# The header text to display when using --help
# This can have multiple lines. In this case, the first line will be used as
# summary wherever appropriate.
help: a sample script generated with bashly

# The string to display when using --version
# Applicable only in the main command
version: 0.1.0

# Specify an array of examples to show when using --help
# Each example can have multiple lines.
examples:
- myscript download
- myscript download --force

# Specify an array of environment variables needed by your script
# This is used purely for displaying in the help text (when using --help)
# The help for each variable can have multiple lines.
environment_variable:
  VARIABLE_NAME: Variable help text

# Specify the array of subcommands to generate.
# Each subcommand will have its own args and flags.
# If this is provided, then you cannot provide flags or args for the main
# script.
# Applicable only in the main command
commands: 
- ...

# Specify the array of positional arguments this script needs.
# If this is provided, then you cannot provide commands for the main script.
args:
- ...

# Specify the array of option flags this script needs.
# If this is provided, then you cannot provide commands for the main script.
flags:
- ...
```


### Argument options

The below configuration generates this argument:

```
  Usage: 
    myscript USER

  Arguments:
    USER
      Username to use for logging in
```

The argument's value will be available to you as `${args[user]}` in your 
bash function.

```yaml
# The name of the argument.
name: user

# The message to display when using --help.
# This can have multiple lines.
help: Username to use for logging in

# Specify if this argument is required.
# Note that once you define an optional argument (without required: true)
# then you cannot define required arguments after it.
required: true
```

### Flag options

The below configuration generates this flag:

```
   -o, --output DIRECTORY (required)
     Specify the output directory
```

The flag's value will be available to you as `${args[--output]}` in your 
bash function (regardless of whether the user provided ut with the long or 
short form).

```yaml
# The long form of the flag.
long: --output

# The short form of the flag.
short: -o

# The text to display when using --help
# This can have multiple lines.
help: Specify the output directory

# If the flag requires an argument, specify its name here.
arg: directory

# Specify if this flag is required.
required: true
```


Real World Examples
--------------------------------------------------

- [Rush][rush] - a Personal Package Manager


Contributing / Support
--------------------------------------------------

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

[issues]: https://github.com/DannyBen/bashly/issues
[rush]: https://github.com/DannyBen/rush-cli
