# Commands Example

Demonstrates how to build a script that supports sub-commands.

This example was generated with:

```bash
$ bashly init
$ bashly generate
```

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
  alias: d
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
  alias: u
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
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



```

### `$ ./cli -h`

```shell
cli - Sample application

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
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



```

### `$ ./cli --version`

```shell
0.1.0


```

### `$ ./cli download -h`

```shell
cli download - Download a file

Alias: d

Usage:
  cli download SOURCE [TARGET] [OPTIONS]
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



```

### `$ ./cli download`

```shell
missing required argument: SOURCE
usage: cli download SOURCE [TARGET] [OPTIONS]


```

### `$ ./cli download sourcefile targetfile -f`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--force]} = 1
- ${args[source]} = sourcefile
- ${args[target]} = targetfile


```

### `$ ./cli upload --help`

```shell
cli upload - Upload a file

Alias: u

Usage:
  cli upload SOURCE [OPTIONS]
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



```

### `$ ./cli upload sourcefile`

```shell
missing required flag: --user, -u USER


```

### `$ ./cli upload sourcefile -u username`

```shell
# this file is located in 'src/upload_command.sh'
# code for 'cli upload' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = sourcefile
- ${args[--user]} = username


```



