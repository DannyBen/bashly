# Split Config Example

Demonstrates how to separate your bashly.yml into several files, and load 
configuration data from other YAML files, or directly from a YAML front matter
in your code.

This example was generated with:

```bash
$ bashly init
$ bashly generate
# ... now edit all files in the src folder ...
$ bashly generate
```

<!-- include: src/download_command.yml src/upload_command.sh src/common_flags.yml -->

-----

## `bashly.yml`

```yaml
name: cli
help: Configuration splitting example
version: 0.1.0

commands:
  # Import a command that is defined in another YAML file
  - import: src/download_command.yml
  
  # Import a command that is defined in the front matter of its own shell
  # function.
  - import: src/upload_command.sh
```

## `src/download_command.yml`

```yaml
name: download
alias: d
help: Download a file

args:
- name: source
  required: true
  help: URL to download from
- name: target
  help: "Target filename (default: same as source)"

flags:
  import: src/common_flags.yml

```

## `src/upload_command.sh`

```bash
# This is a YAML front matter describing the command
# It is imported to bashly.yml when running "bashly generate"

name: upload
alias: u
help: Upload a file
args:
- name: source
  required: true
  help: File to upload

flags:
  import: src/common_flags.yml

---
# Shell script starts here
inspect_args

```

## `src/common_flags.yml`

```yaml
- long: --force
  short: -f
  help: Overwrite existing files

```


## Generated script output

### `$ ./cli`

```shell
cli - Configuration splitting example

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



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



```

### `$ ./cli upload -h`

```shell
cli upload - Upload a file

Alias: u

Usage:
  cli upload SOURCE [OPTIONS]
  cli upload --help | -h

Options:
  --help, -h
    Show this help

  --force, -f
    Overwrite existing files

Arguments:
  SOURCE
    File to upload



```



