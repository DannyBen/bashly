# Default Command Example

Demonstrates how to set a command as the default command. This command can be
executed without explicitly specifying the command name.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: ftp
help: Sample application that uses the default command option
version: 0.1.0

commands:
- name: upload
  alias: u
  help: Upload a file

  # By setting the `upload` command as the default command, it will be executed
  # when the command line is not recognized.
  # Running `ftp upload something` is the same as `ftp something`
  default: true

  args:
  - name: source
    required: true
    help: File to upload

- name: download
  alias: d
  help: Download a file

  args:
  - name: source
    required: true
    help: File to download
````



## Output

### `$ ./ftp`

````shell
ftp - Sample application that uses the default command option

Usage:
  ftp COMMAND
  ftp [COMMAND] --help | -h
  ftp --version | -v

Commands:
  upload     Upload a file (default)
  download   Download a file



````

### `$ ./ftp -h`

````shell
ftp - Sample application that uses the default command option

Usage:
  ftp COMMAND
  ftp [COMMAND] --help | -h
  ftp --version | -v

Commands:
  upload     Upload a file (default)
  download   Download a file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./ftp download something`

````shell
# This file is located at 'src/download_command.sh'.
# It contains the implementation for the 'ftp download' command.
# The code you write here will be wrapped by a function named 'ftp_download_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[source]} = something


````

### `$ ./ftp upload`

````shell
missing required argument: SOURCE
usage: ftp [upload] SOURCE


````

### `$ ./ftp upload -h`

````shell
ftp upload - Upload a file

Alias: u

Usage:
  ftp [upload] SOURCE
  ftp upload --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  SOURCE
    File to upload



````

### `$ ./ftp upload something`

````shell
# This file is located at 'src/upload_command.sh'.
# It contains the implementation for the 'ftp upload' command.
# The code you write here will be wrapped by a function named 'ftp_upload_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[source]} = something


````

### `$ ./ftp something`

````shell
# This file is located at 'src/upload_command.sh'.
# It contains the implementation for the 'ftp upload' command.
# The code you write here will be wrapped by a function named 'ftp_upload_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[source]} = something


````



