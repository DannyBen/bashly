# Catch All Advanced Example

Demonstrates the advanced form of `catch_all`, where you can specify a help message .

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

commands:
- name: download
  short: d
  help: Download a file

  # Configure catch_all for the `download` sub-command using the extended
  # syntax which adds a proper help message.
  catch_all:
    label: AWS Params
    help: Additional arguments or flags for AWS CLI

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

### `$ ./cli`

```shell
cli - Sample application

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



```

### `$ ./cli download -h`

```shell
cli download - Download a file

Shortcut: d

Usage:
  cli download SOURCE [TARGET] [options] [AWS PARAMS...]
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

  AWS PARAMS...
    Additional arguments or flags for AWS CLI

Examples:
  cli download example.com
  cli download example.com ./output -f



```

### `$ ./cli download source`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = source


```

### `$ ./cli download source target`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = source
- ${args[target]} = target


```

### `$ ./cli download source target and --additional stuff`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = source
- ${args[target]} = target

other_args:
- ${other_args[*]} = and --additional stuff
- ${other_args[0]} = and
- ${other_args[1]} = --additional
- ${other_args[2]} = stuff


```



