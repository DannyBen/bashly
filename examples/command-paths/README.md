# Command Paths Example

Demonstrates how to globally change the path used for command files and instruct
bashly to read/write command files to nested sub-directories.

This is useful for scripts with many commands,

Note that the specified path is relative to the `src` folder.

See also: [Command Filenames Example](/examples/command-filenames#readme)

This example was generated with:

```bash
$ bashly init
$ bashly add settings
# ... now edit src/settings.yml to match the example ...
$ bashly generate
```

<!-- include: settings.yml -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

environment_variables:
- name: api_key
  help: Set your API key

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

## `settings.yml`

```yaml
# The path to use for command files, relative to source_dir
# When set to nil (~), command files will be placed directly under source_dir
# When set to any other string, command files will be placed under this
# directory, and each command will get its own subdirectory

# commands_dir: ~
commands_dir: commands

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

### `$ ./cli download something`

```shell
# this file is located in 'src/commands/download.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = something


```

### `$ ls -1 src/*`

```shell
src/bashly.yml

src/commands:
download.sh
upload.sh


```



