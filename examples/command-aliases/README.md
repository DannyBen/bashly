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

```yaml
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

### `$ ./cli download -h`

```shell
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



```

### `$ ./cli d somefile`

```shell
# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = somefile


```

### `$ ./cli upload --help`

```shell
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



```

### `$ ./cli u --help`

```shell
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



```

### `$ ./cli push somefile`

```shell
# this file is located in 'src/upload_command.sh'
# code for 'cli upload' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[source]} = somefile


```



