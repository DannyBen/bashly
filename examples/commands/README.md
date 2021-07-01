# Commands Example

Demonstrates how to build a script that supports sub-commands.

This example was generated with:

    $ bashly init
    $ bashly generate

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

environment_variables:
- name: api_key
  help: Set your API key

# Specifying a `commands` array configures the generated script to support
# sub-commands.
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

  examples:
  - cli download example.com
  - cli download example.com ./output -f

  environment_variables:
  - name: default_target_location
    help: Set the default location to download to

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

## Generated script output

```shell
$ ./cli

cli - Sample application

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



$ ./cli -h

cli - Sample application

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  API_KEY
    Set your API key



$ ./cli --version

0.1.0


$ ./cli download -h

cli download - Download a file

Shortcut: d

Usage:
  cli download SOURCE [TARGET] [options]
  cli download --help | -h

Options:
  --help, -h
    Show this help

  --force, -f
    Overwrite existing files

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Environment Variables:
  DEFAULT_TARGET_LOCATION
    Set the default location to download to

Examples:
  cli download example.com
  cli download example.com ./output -f



$ ./cli download

missing required argument: SOURCE
usage: cli download SOURCE [TARGET] [options]


$ ./cli download sourcefile targetfile -f

# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--force]} = 1
- ${args[source]} = sourcefile
- ${args[target]} = targetfile


$ ./cli upload --help

cli upload - Upload a file

Shortcut: u

Usage:
  cli upload SOURCE [options]
  cli upload --help | -h

Options:
  --help, -h
    Show this help

  --user, -u USER (required)
    Username to use for logging in

  --password, -p PASSWORD
    Password to use for logging in

Arguments:
  SOURCE
    File to upload



$ ./cli upload sourcefile

missing required flag: --user, -u USER


$ ./cli upload sourcefile -u username

# this file is located in 'src/upload_command.sh'
# code for 'cli upload' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = sourcefile
- ${args[--user]} = username


```



