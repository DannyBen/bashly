# Command Aliases Example

Demonstrates how to set multiple aliases to a command.

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

environment_variables:
- name: api_key
  help: Set your API key

commands:
- name: download

  # alias the "download" command as "d"
  alias: d
  help: Download a file

  args:
  - name: source
    required: true
    help: URL to download from
  - name: target
    help: "Target filename (default: same as source)"

  examples:
  - cli download example.com
  - cli d example.com ./output

- name: upload

  # alias the "upload" command as both "u" and "push"
  alias: [u, push]
  help: Upload a file
  args:
  - name: source
    required: true
    help: File to upload

  examples:
  - cli upload README.md
  - cli push README.md
  - cli u README.md
````



## Output

### `$ ./cli`

````shell
cli - Sample application

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



````

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

Environment Variables:
  API_KEY
    Set your API key



````

### `$ ./cli download -h`

````shell
cli download - Download a file

Alias: d

Usage:
  cli download SOURCE [TARGET]
  cli download --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Examples:
  cli download example.com
  cli d example.com ./output



````

### `$ ./cli d somefile`

````shell
# This file is located at 'src/download_command.sh'.
# It contains the implementation for the 'cli download' command.
# The code you write here will be wrapped by a function named 'cli_download_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[source]} = somefile

environment variables:
- $API_KEY = 


````

### `$ ./cli upload --help`

````shell
cli upload - Upload a file

Alias: u, push

Usage:
  cli upload SOURCE
  cli upload --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  SOURCE
    File to upload

Examples:
  cli upload README.md
  cli push README.md
  cli u README.md



````

### `$ ./cli u --help`

````shell
cli upload - Upload a file

Alias: u, push

Usage:
  cli upload SOURCE
  cli upload --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  SOURCE
    File to upload

Examples:
  cli upload README.md
  cli push README.md
  cli u README.md



````

### `$ ./cli push somefile`

````shell
# This file is located at 'src/upload_command.sh'.
# It contains the implementation for the 'cli upload' command.
# The code you write here will be wrapped by a function named 'cli_upload_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[source]} = somefile

environment variables:
- $API_KEY = 


````



