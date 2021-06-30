<div align='center'>
<img src='logo.svg' width=280>

# Bashly - Bash CLI Framework and Generator

Create beautiful bash scripts from simple YAML configuration

[![Gem Version](https://badge.fury.io/rb/bashly.svg)](https://badge.fury.io/rb/bashly)
[![Build Status](https://github.com/DannyBen/bashly/workflows/Test/badge.svg)](https://github.com/DannyBen/bashly/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/8cf89047e50ca601e431/maintainability)](https://codeclimate.com/github/DannyBen/bashly/maintainability)

---

![demo](demo/cast.svg)

</div>

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Installation](#installation)
- [Prerequisites](#prerequisites)
- [What is Bashly](#what-is-bashly)
- [Usage](#usage)
  - [Using the input arguments in your code](#using-the-input-arguments-in-your-code)
- [Examples](#examples)
  - [Sample configuration for a script without commands](#sample-configuration-for-a-script-without-commands)
  - [Sample configuration for a script with commands](#sample-configuration-for-a-script-with-commands)
- [Configuration Reference](#configuration-reference)
  - [Command options](#command-options)
  - [Argument options](#argument-options)
  - [Flag options](#flag-options)
  - [Environment Variable options](#environment-variable-options)
- [Extensible Commands](#extensible-commands)
- [Real World Examples](#real-world-examples)
- [Contributing / Support](#contributing--support)

---

## Installation

```shell
$ gem install bashly
```

or with Docker:

```shell
$ alias bashly='docker run --rm -it --volume "$PWD:/app" dannyben/bashly'
```

## Prerequisites

The bash scripts generated by bashly require bash 4 or higher due to heavy
use of associative arrays.


## What is Bashly

Bashly is a command line application (written in Ruby) that lets you generate
feature-rich bash command line tools.

The design intention is to let you focus on your specific code, without 
worrying about command line argument parsing, usage texts, error messages
and other functions that are usually handled by a framework in any other
programming language.

Bahsly is responsible for:

- Generating a **single, standalone bash script**.
- Generating **usage texts** and help screens, showing your tool's arguments, 
  flags and commands (works for subcommands also).
- Parsing the user's command line and extracting:
  - Optional or required **positional arguments**.
  - Optional or required **option flags** (with or without flag arguments).
  - **Commands** (and subcommands).
  - Standard flags (like **--help** and **--version**).
- Providing you with a place to input your code for each of the functions 
  your tool performs, and merging it back to the final script.
- Providing you with additional (optional) framework-style, standard
  library functions:
  - **Color output**.
  - **Config file management** (INI format).
  - **YAML parsing**.
  - and more.

## Usage

In an empty directory, create a sample configuration file by running

```shell
$ bashly init
# or, to generate a simpler configuration:
$ bashly init --minimal
```

This will create a sample `src/bashly.yml` file.
You can edit this file to specify which arguments, flags and commands you
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

### Using the input arguments in your code

In order to access the parsed arguments in any of your partial scripts, you
may simply access the `$args` associative array.

For example:

1. Generate a minimal configuration with `bashly init --minimal`
2. Generate the bash script with `bashly generate`
3. Run the script with `./download hello --force`

You will notice that all the arguments of the associative array are printed 
on screen. This is done by the `inspect_args` function that was inserted into
the generated partial script `src/root_command.sh`.

You can now access these variables by modifying `sec/root_command.sh` like
this:


```bash
# src/root_command.sh
source_url=${args[source]}
force=${args[--force]}

if [[ $force ]]; then
  echo "downloading $source_url with --force"
else
  echo "downloading $source_url"
fi
```

After editing the file, run `bashly generate` (or `bashly g` for short) and
run:

```
$ ./download a --force
downloading a with --force
```

## Examples

The `bashly.yml` file can be set up to generate two types of scripts:

1. Script with commands (for example, like `docker` or `git`).
2. Script without commands (for example, like `ls`)

This is detected automatically by the contents of the configuration: If it
contains a `commands` definition, it will generate a script with commands.


### Sample configuration for a script without commands

- Generate this script by running `bashly generate --minimal`
- [See the initial sample bashly.yml file](examples/minimal/src/bashly.yml)
- [See the generated bash script](examples/minimal/download)

### Sample configuration for a script with commands

- Generate this script by running `bashly generate`
- [See the initial sample bashly.yml file](examples/commands/src/bashly.yml)
- [See the generated bash script](examples/commands/cli)


See the [examples](examples) folder for more examples.



## Configuration Reference

The `bashly.yml` configuration file consists of these types:

- [Command](#command-options) - defines the root command as well as any 
  subcommand.
- [Argument](#argument-options) - defines positional arguments.
- [Flag](#flag-options) - defines option flags.
- [Environment Variable](#environment-variable-options) - defines 
  environment variables required (or desired) by your script.

### Command options

Unless otherwise specified, these definitions can be used for both the root
command and subcommands (under the `commands` definition).

 Option    | Description
-----------|-------------
`name`     | The name of the script or subcommand.
`short`    | An additional, optional pattern - usually used to denote a one letter variation of the command name. You can add `*` as a suffix, to denote a "starts with" pattern - for example `short: m*`. *Applicable only in subcommands*.
`help`     | The header text to display when using `--help`. This option can have multiple lines. In this case, the first line will be used as summary wherever appropriate.
`version`  | The string to display when using `--version`. *Applicable only in the main command*.
`default`  | Setting this to `true` on any command, will cause any unrecognized command line to be passed to this command. *Applicable only in subcommands*.
`extensible` | Specify that this command can be [externally extended](#extensible-commands).
`examples` | Specify an array of examples to show when using `--help`. Each example can have multiple lines.
`environment_variables` | Specify an array of [environment variables](#environment-variable-options) needed by your script. 
`commands` | Specify the array of [commands](#command-options). Each command will have its own args and flags. Note: if `commands` is provided, you cannot specify flags or args at the same level.
`args`     | Specify the array of [positional arguments](#argument-options) this script needs.
`flags`    | Specify the array of option [flags](#flag-options) this script needs.
`catch_all` | Specify that this command should allow for additional arbitrary arguments or flags. It can be set in one of three ways:<br>- Set to `true` to just enable it.<br>- Set to a string, to use this string in the usage help text.<br>- Set to a hash containing `label` and `help` keys, to show a detailed help for it when running with `--help`.
`dependencies` | Specify an array of any required external dependencies (commands). The script execution will be halted with a friendly error unless all dependency commands exist.
`group`    | In case you have many commands, use this option to specify a caption to display before this command. This option is purely for display purposes, and needs to be specified only for the first command in each group.

### Argument options

The argument's value will be available to you as `${args[user]}` in your 
bash function.

 Option    | Description
-----------|-------------
`name`     | The name of the argument.
`help`     | The message to display when using `--help`. Can have multiple lines.
`required` | Specify if this argument is required. Note that once you define an optional argument (without required: true) then you cannot define required arguments after it.
`default`  | The value to use in case it is not provided by the user. Implies that this argument is optional.
`allowed`  | Limit the allowed values by providing an array.

### Flag options

The flag's value will be available to you as `${args[--output]}` in your 
bash function (regardless of whether the user provided it with the long or 
short form).

 Option    | Description
-----------|-------------
`long`     | The long form of the flag.
`short`    | The short form of the flag.
`help`     | The text to display when using `--help`. Can have multiple lines.
`arg`      | If the flag requires an argument, specify its name here.
`required` | Specify if this flag is required.
`default`  | The value to use in case it is not provided by the user. Implies that this flag is optional, and only makes sense when the flag has an argument.
`allowed`  | For flags with an argument, you can limit the allowed values by providing an array.

#### Special handling for -v and -h

The `-v` and `-h` flags will be used as the short options for `--version` and
`--help` respectively **only if you are not using them in any of your own
flags**.

### Environment Variable options

The below configuration generates this environment variable usage text:

If an environment variable is defined as required (false by default), the
execution of the script will be halted with a friendly error if it is not
set.

 Option    | Description
-----------|-------------
`name`     | The name of the variable (it will be automatically capitalized).
`help`     | The message to display when using --help. Can have multiple lines.
`required` | Specify if this variable is required.


## Extensible Commands

You may configure your generated bash script to delegate any unknown command
to an external executable, by setting the `extensible` option to either `true`,
or to a different external command.

This is similar to how `git` works. When you execute `git whatever`, the `git`
command will look for a file named `git-whatever` in the path, and execute it.

Note that this option cannot be specified together with the `default` option,
since both specify a handler for unknown commands.

Bashly supports two operation modes.

### Extension Mode (`extensible: true`)

By setting `extensible` to `true`, a specially named executable will be called
when an unknown command is called by the user.

Given this `bashly.yml` configuration:

```yaml
name: myscript
help: Example
version: 0.1.0
extensible: true

commands:
- name: upload
  help: Upload a file
```

And this user command:

```
$ myscript something

```

The generated script will look for an executable named `myscript-something` 
in the path. If found, it will be called.

See the [extensible example](examples/extensible)


### Delegate Mode (`extensible: <executable name>`)

By setting `extensible` to any string, unknown command calls by the user will
be delegated to the executable with that name.

Given this `bashly.yml` configuration:

```yaml
name: mygit
help: Example
version: 0.1.0
extensible: git

commands:
- name: push
  help: Push to my repository
```

And this user command:

```
$ mygit status

```

The generated script will execute `git status`.

See the [extensible-delegate example](examples/extensible-delegate)



## Real World Examples

- [Rush][rush] - a Personal Package Manager
- [Alf][alf] - a generator for bash aliases and sub-aliases
- [git-changelog][git-changelog] - a change log generator


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].



[issues]: https://github.com/DannyBen/bashly/issues
[rush]: https://github.com/DannyBen/rush-cli
[alf]: https://github.com/DannyBen/alf
[git-changelog]: https://github.com/DannyBen/git-changelog
