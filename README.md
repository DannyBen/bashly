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

Usage
--------------------------------------------------

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


Examples
--------------------------------------------------

The `bashly.yml` file can be set up to generate two types of scripts:

1. Script with commands (for example, like `docker` or `git`).
2. Script without commands (for example, like `ls`)

This is detected automatically by the contents of the configuration: If it
contains a `commands` definition, it will generate a script with commands.


### Sample configuraiton for a script without commands

- Generate this script by running `bashly generate --minimal`
- [See the initial sample bashly.yml file](examples/minimal/src/bashly.yml)
- [See the generated bash script](examples/minimal/download)

### Sample configuraiton for a script with commands

- Generate this script by running `bashly generate`
- [See the initial sample bashly.yml file](examples/commands/src/bashly.yml)
- [See the generated bash script](examples/commands/cli)


See the [examples](examples) folder for more examples.



Configuration Reference
--------------------------------------------------

The `bashly.yml` configuration file consists of these types:

- [Command](#command-options) - defines the root command as well as any 
  subcommand.
- [Argument](#argument-options) - defines positional arguments.
- [Flag](#flag-options) - defines option flags.
- [Environment Variable](#environment-variable-options) - defines 
  environment variables required (or desired) by your script.

### Command options

Unless otherwise specified, these definitiona can be used for both the root
command and subcommands (under the `commands` definition).


 Option    | Description
-----------|-------------
`name`     | The name of the script or subcommand.
`short`    | An additional, optional pattern - usually used to denote a one letter variation of the command name. You can add `*` as a suffix, to denote a "starts with" pattern - for example `short: m*`. *Applicable only in subcommands*.
`help`     | The header text to display when using `--help`. This option can have multiple lines. In this case, the first line will be used as summary wherever appropriate.
`version`  | The string to display when using `--version`. *Applicable only in the main command*.
`default`  | Setting this to `yes` on any command, will make unrecognized command line arguments to be passed to this command. *Applicable only in subcommands*.
`examples` | Specify an array of examples to show when using `--help`. Each example can have multiple lines.
`environment_variables` | Specify an array of environment variables needed by your script. 
`commands` | Specify the array of commands. Each command will have its own args and flags. Note: if `commands` is provided, you cannot specify flags or args at the same level.
`args`     | Specify the array of positional arguments this script needs.
`flags`    | Specify the array of option flags this script needs.
`dependencies` | Specify an array of any required external dependencies (commands). The script execution will be halted with a friendly error unless all dependency commands exist.
`group`    | In case you have many commands, use this option to specify a caption to display before this command. This option is purely for display purposes, and needs to be specified only once for each group.

### Argument options

The argument's value will be available to you as `${args[user]}` in your 
bash function.

 Option    | Description
-----------|-------------
`name`     | The name of the argument.
`help`     | The message to display when using `--help`. Can have multiple lines.
`required` | Specify if this argument is required. Note that once you define an optional argument (without required: true) then you cannot define required arguments after it.

### Flag options

The flag's value will be available to you as `${args[--output]}` in your 
bash function (regardless of whether the user provided ut with the long or 
short form).

 Option    | Description
-----------|-------------
`long`     | The long form of the flag.
`short`    | The short form of the flag.
`help`     | The text to display when using `--help`. Can have multiple lines.
`arg`      | If the flag requires an argument, specify its name here.
`required` | Specify if this flag is required.

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


Real World Examples
--------------------------------------------------

- [Rush][rush] - a Personal Package Manager


Contributing / Support
--------------------------------------------------

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

[issues]: https://github.com/DannyBen/bashly/issues
[rush]: https://github.com/DannyBen/rush-cli
