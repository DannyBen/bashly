# Command Examples Example

Demonstrates how to add examples to your command.

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

  # Examples can be provided either as an array, or as a string.
  # The array form is convenient when you just want to provide one-liner
  # examples.
  examples:
  - cli download example.com
  - cli download example.com ./output -f

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

  # The string form examples is useful when you wish to have more control
  # over how the examples are displayed. Note the use of the '|-' marker
  # that tells YAML to use the string as is, including the newlines it contains.
  examples: |-
    Upload a file 
    $ cli upload profile.png -u admin -p s3cr3t

    Upload a file (you will be prompted to provide a password)
    $ cli upload profile.png --user admin
```



## Generated script output

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

Examples:
  cli download example.com
  cli download example.com ./output -f



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

  --user, -u USER (required)
    Username to use for logging in

  --password, -p PASSWORD
    Password to use for logging in

Arguments:
  SOURCE
    File to upload

Examples:
  Upload a file
  $ cli upload profile.png --user admin
  
  Upload a file and prompt for password
  $ cli upload profile.png -u admin -p



```



