# Reusable Flags Example

Demonstrates how to use YAML anchors to apply the same flags to multiple
commands. Note that this is a standard YAML feature, and is not bashly specific.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

commands:
- name: download
  help: Download a file

  # Label these flags (&force, &debug) so we can reference it later
  flags:
  - &force
    long: --force
    short: -f
    help: Overwrite existing files

  - &debug
    long: --debug
    short: -d
    help: Show debug information

- name: upload
  help: Upload a file

  # Reuse previously defined flags, and then add new ones
  flags:
  - *force
  - *debug
  - long: --password
    short: -p
    arg: password
    help: Password to use for logging in
```



## Generated script output

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



```

### `$ ./cli download -h`

```shell
cli download - Download a file

Usage:
  cli download [OPTIONS]
  cli download --help | -h

Options:
  --help, -h
    Show this help

  --force, -f
    Overwrite existing files

  --debug, -d
    Show debug information



```

### `$ ./cli upload -h`

```shell
cli upload - Upload a file

Usage:
  cli upload [OPTIONS]
  cli upload --help | -h

Options:
  --help, -h
    Show this help

  --force, -f
    Overwrite existing files

  --debug, -d
    Show debug information

  --password, -p PASSWORD
    Password to use for logging in



```

### `$ ./cli upload --force`

```shell
# this file is located in 'src/upload_command.sh'
# code for 'cli upload' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--force]} = 1


```

### `$ ./cli download --debug`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--debug]} = 1


```



