# Command Examples on Error Example

Demonstrates how to show examples whenever the user does not provide all the
required arguments.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add settings
# ... now edit settings.yml to match the example ...
$ bashly generate
```

<!-- include: settings.yml -->

-----

## `bashly.yml`

````yaml
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
````

## `settings.yml`

````yaml
show_examples_on_error: true

````


## Output

### `$ ./cli download`

````shell
missing required argument: SOURCE
usage: cli download SOURCE [TARGET] [OPTIONS]
examples:
  cli download example.com
  cli download example.com ./output -f


````

### `$ ./cli upload`

````shell
missing required argument: SOURCE
usage: cli upload SOURCE [OPTIONS]
examples:
  Upload a file
  $ cli upload profile.png -u admin -p s3cr3t
  
  Upload a file (you will be prompted to provide a password)
  $ cli upload profile.png --user admin


````



