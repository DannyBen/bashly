# Colors Usage Example

This example demonstrates how to apply colors to various usage elements.

This example was generated with:

```bash
$ bashly init
$ bashly add colors
$ bashly add settings
# ... now edit settings.yml to match the example ...
$ bashly generate
```

The `bashly add colors` command, simply created the [src/lib/colors.sh]
(src/lib/colors.sh) file, with useful color functions that will be
automatically included in the generated script.

The manually modified `settings.yml` file specifies which color function is
used for which usage element.

Note that the output displayed in this README is not colored.

<!-- include: settings.yml -->

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
````

## `settings.yml`

````yaml
# Display various usage elements in color by providing the name of the color
# function. The value for each property is a name of a function that is
# available in your script, for example: `green` or `bold`.
# You can run `bashly add colors` to add a standard colors library.
# This option cannot be set via environment variables.
usage_colors:
  caption: bold
  command: green
  arg: blue
  flag: magenta
  environment_variable: cyan

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
  cli download SOURCE [TARGET] [OPTIONS]
  cli download --help | -h

Options:
  --force, -f
    Overwrite existing files

  --help, -h
    Show this help

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Environment Variables:
  DEFAULT_TARGET_LOCATION
    Set the default location to download to

Examples:
  cli download example.com
  cli download example.com ./output -f



````



