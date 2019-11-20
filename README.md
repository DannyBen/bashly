Bashly - Bash CLI Generator
==================================================

Create beautiful bash scripts from simple YAML configuration.

[![Gem Version](https://badge.fury.io/rb/bashly.svg)](https://badge.fury.io/rb/bashly)
[![Build Status](https://travis-ci.com/DannyBen/bashly.svg?branch=master)](https://travis-ci.com/DannyBen/bashly)
[![Maintainability](https://api.codeclimate.com/v1/badges/8cf89047e50ca601e431/maintainability)](https://codeclimate.com/github/DannyBen/bashly/maintainability)

---

![demo](demo/cast.svg)

---

Installation
--------------------------------------------------

    $ gem install bashly


Usage
--------------------------------------------------

In an empty directory, create a sample configuration file by running

    $ bashly init
    # or, to generate a simpler configuration:
    $ bashly init --minimal

This will create a sample `src/bashly.yml` file.
You can edit this file to specify which arguments, flags and subcommands you
need in your bash script.

Then, generate an initial bash script and function placeholder scripts by
running

    $ bashly generate

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

You can get this script by running `bashly generate --minimal`.

```yaml
name: download
help: Sample minimal application without subcommands
version: 0.1.0

args:
- name: source
  required: true
  help: URL to download from
- name: target
  help: "Target filename (default: same as source)"

flags:
- long: --force
  short: -f
  help: Overwrite existing files
```


### Sample configuraiton for a script with subcommands

You can get this script by running `bashly generate`.

```yaml
name: cli
help: Sample application
version: 0.1.0

commands:
- name: download
  short: d
  help: Download a file

  args:
  - name: source
    required: true
    help: URL to download from
  - name: target
    help: "Target filename (default: same as source)"

  flags:
  - long: --force
    short: -f
    help: Overwrite existing files

- name: upload
  short: u
  help: Upload a file
  args:
  - name: source
    required: true
    help: File to upload

  flags:
  - long: --user
    short: -u
    arg: user
    help: Username to use for logging in
    required: true
  - long: --password
    short: -p
    arg: password
    help: Password to use for logging in
```


Configuration Reference
--------------------------------------------------

### Command options

With the exception of `version` and `commands` (shich define subcommands),
everything else in this section is suitable both for the main script, and for
any subcommand you define using `commands`.

```yaml
# The name of the script or subcommand
name: myscript

# The header text to display when using --help
# This can have multiple lines. In this case, the first line will be used as
# summary wherever appropriate.
help: a sample script generated with bashly

# The string to display when using --version
version: 0.1.0

# Specify the array of subcommands to generate.
# Each subcommand will have its own args and flags.
# If this is provided, then you cannot provide flags or args for the main
# script.
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
# This can have multiple lines, but it is recommended to keep lines shorter
# than ~70 characters, to avoid text wrapping in narrower terminals.
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

The flags's value will be available to you as `${args[--output]}` in your 
bash function (regardless of whether the user provided ut with the long or 
short form).

```yaml
# The long form of the flag.
long: --output

# The short form of the flag.
short: -o

# The text to display when using --help
# This can have multiple lines, but it is recommended to keep lines shorter
# than ~70 characters, to avoid text wrapping in narrower terminals.
help: Specify the output directory

# If the flag requires an argument, specify its name here.
arg: directory

# Specify if this flag is required.
required: true
```

Contributing / Support
--------------------------------------------------

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

[issues]: https://github.com/DannyBen/bashly/issues

