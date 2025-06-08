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

````yaml
name: cli
help: Sample application
version: 0.1.0

commands:
- name: download
  help: Download a file

  # Label these flags (&force, &debug) so we can reference them later
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
````



## Output

### `$ ./cli -h`

````shell
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



````

### `$ ./cli download -h`

````shell
cli download - Download a file

Usage:
  cli download [OPTIONS]
  cli download --help | -h

Options:
  --force, -f
    Overwrite existing files

  --debug, -d
    Show debug information

  --help, -h
    Show this help



````

### `$ ./cli upload -h`

````shell
cli upload - Upload a file

Usage:
  cli upload [OPTIONS]
  cli upload --help | -h

Options:
  --force, -f
    Overwrite existing files

  --debug, -d
    Show debug information

  --password, -p PASSWORD
    Password to use for logging in

  --help, -h
    Show this help



````

### `$ ./cli upload --force`

````shell
# This file is located at 'src/upload_command.sh'.
# It contains the implementation for the 'cli upload' command.
# The code you write here will be wrapped by a function named 'cli_upload_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--force]} = 1


````

### `$ ./cli download --debug`

````shell
# This file is located at 'src/download_command.sh'.
# It contains the implementation for the 'cli download' command.
# The code you write here will be wrapped by a function named 'cli_download_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--debug]} = 1


````



