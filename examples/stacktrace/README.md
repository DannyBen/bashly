# Stack Trace Example

Demonstrates how to show stack trace on error.

This example was generated with:

```bash
$ bashly init --minimal
$ bashly add stacktrace
$ bashly generate
# ... now create and edit src/initialize.sh to match the example ...
# ... now edit src/root_command.sh to match the example ...
$ bashly generate
```

<!-- include: src/initialize.sh -->
<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

````yaml
name: download
help: Sample minimal application without commands
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

examples:
- download example.com
- download example.com ./output -f
````

## `src/initialize.sh`

````bash
## initialize hook
##
## Any code here will be placed inside the `initialize()` function and called
## before running anything else.
##
## You can safely delete this file if you do not need it.
trap 'stacktrace' ERR
set -o errtrace

````


## Output

### `$ ./download`

````shell
missing required argument: SOURCE
usage: download SOURCE [TARGET] [OPTIONS]


````

### `$ ./download --help`

````shell
download - Sample minimal application without commands

Usage:
  download SOURCE [TARGET] [OPTIONS]
  download --help | -h
  download --version | -v

Options:
  --force, -f
    Overwrite existing files

  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Examples:
  download example.com
  download example.com ./output -f



````

### `$ ./download something`

````shell
./download: line 15: no_such_command: command not found
./download:15 in `root_command`: no_such_command

Stack trace:
	from ./download:15 in `root_command`
	from ./download:254 in `run`
	from ./download:260 in `main`


````



