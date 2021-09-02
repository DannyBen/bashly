# Catch All Example

Demonstrates the use of the `catch_all` option, which will allows any command
to receive an arbitrary list of arguments.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: download
help: Catch All Example
version: 0.1.0

# Enable catch_all for the root command
catch_all: true

args:
- name: message
  required: true
  help: Message
```



## Generated script output

### `$ ./download`

```shell
missing required argument: MESSAGE
usage: download MESSAGE [...]


```

### `$ ./download -h`

```shell
download - Catch All Example

Usage:
  download MESSAGE [...]
  download --help | -h
  download --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  MESSAGE
    Message



```

### `$ ./download something`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[message]} = something


```

### `$ ./download something with --additional args`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[message]} = something

other_args:
- ${other_args[*]} = with --additional args
- ${other_args[0]} = with
- ${other_args[1]} = --additional
- ${other_args[2]} = args


```



