# Default Values Example

Demonstrates how to set default values for arguments and flags.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: convert
help: Sample application using default arguments and flags
version: 0.1.0

args:
- name: source
  help: Files to convert

  # By setting a default value for the argument, this value will be used
  # when `source` is not provided.
  default: "*.jpg"

flags:
- long: --format
  short: -f
  arg: format
  help: Format to convert to

  # Default values can also be applied to flags.
  default: png

examples:
- convert *.bmp
- convert --format jpg
- convert *.bmp --format jpg
````



## Output

### `$ ./convert`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'convert' command.
# The code you write here will be wrapped by a function named 'convert_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--format]} = png
- ${args[source]} = *.jpg


````

### `$ ./convert -h`

````shell
convert - Sample application using default arguments and flags

Usage:
  convert [SOURCE] [OPTIONS]
  convert --help | -h
  convert --version | -v

Options:
  --format, -f FORMAT
    Format to convert to
    Default: png

  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  SOURCE
    Files to convert
    Default: *.jpg

Examples:
  convert *.bmp
  convert --format jpg
  convert *.bmp --format jpg



````

### `$ ./convert *.bmp`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'convert' command.
# The code you write here will be wrapped by a function named 'convert_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--format]} = png
- ${args[source]} = *.bmp


````

### `$ ./convert -f pdf`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'convert' command.
# The code you write here will be wrapped by a function named 'convert_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--format]} = pdf
- ${args[source]} = *.jpg


````

### `$ ./convert *.pdf --format gif`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'convert' command.
# The code you write here will be wrapped by a function named 'convert_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--format]} = gif
- ${args[source]} = *.pdf


````



