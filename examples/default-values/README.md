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

```yaml
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
```



## Generated script output

### `$ ./convert`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--format]} = png
- ${args[source]} = *.jpg


```

### `$ ./convert -h`

```shell
convert - Sample application using default arguments and flags

Usage:
  convert [SOURCE] [OPTIONS]
  convert --help | -h
  convert --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --format, -f FORMAT
    Format to convert to
    Default: png

Arguments:
  SOURCE
    Files to convert
    Default: *.jpg

Examples:
  convert *.bmp
  convert --format jpg
  convert *.bmp --format jpg



```

### `$ ./convert *.bmp`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--format]} = png
- ${args[source]} = *.bmp


```

### `$ ./convert -f pdf`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--format]} = pdf
- ${args[source]} = *.jpg


```

### `$ ./convert *.pdf --format gif`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--format]} = gif
- ${args[source]} = *.pdf


```



