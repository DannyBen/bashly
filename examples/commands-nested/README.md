# Sub-Commands Example

Demonstrates how to commands can be nested inside other commands.

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
help: Sample application with nested commands
version: 0.1.0

commands:
- name: dir
  alias: d
  help: Directory commands

  # The `commands` array can be nested inside any other command
  # This particular array will generate a script that answers to
  # `cli dir list` and `cli dir remove`
  commands:
  - name: list
    help: Show files in the directory

    args: &dir_args
    - name: path
      help: Directory path
      required: true

  - name: remove
    help: Remove directory
    args: *dir_args   # reuse args from the list command

    flags:
    - long: --force
      short: -f
      help: Remove even if when not empty

- name: file
  alias: f
  help: File commands

  # The nested commands for `cli file` - will generate `cli file show` and
  # `cli file edit`.
  commands:
  - name: show
    help: Show file contents
    args: &file_args
    - name: path
      help: Path to file
      required: true

  - name: edit
    help: Edit the file
    args: *file_args   # reuse args from the show command
```



## Generated script output

### `$ ./cli`

```shell
cli - Sample application with nested commands

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  dir    Directory commands
  file   File commands



```

### `$ ./cli -h`

```shell
cli - Sample application with nested commands

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  dir    Directory commands
  file   File commands

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



```

### `$ ./cli dir`

```shell
cli dir - Directory commands

Alias: d

Usage:
  cli dir COMMAND
  cli dir [COMMAND] --help | -h

Commands:
  list     Show files in the directory
  remove   Remove directory



```

### `$ ./cli file`

```shell
cli file - File commands

Alias: f

Usage:
  cli file COMMAND
  cli file [COMMAND] --help | -h

Commands:
  show   Show file contents
  edit   Edit the file



```

### `$ ./cli dig`

```shell
invalid command: dig


```

### `$ ./cli dir -h`

```shell
cli dir - Directory commands

Alias: d

Usage:
  cli dir COMMAND
  cli dir [COMMAND] --help | -h

Commands:
  list     Show files in the directory
  remove   Remove directory

Options:
  --help, -h
    Show this help



```

### `$ ./cli file -h`

```shell
cli file - File commands

Alias: f

Usage:
  cli file COMMAND
  cli file [COMMAND] --help | -h

Commands:
  show   Show file contents
  edit   Edit the file

Options:
  --help, -h
    Show this help



```

### `$ ./cli dir list`

```shell
missing required argument: PATH
usage: cli dir list PATH


```

### `$ ./cli dir list -h`

```shell
cli dir list - Show files in the directory

Usage:
  cli dir list PATH
  cli dir list --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  PATH
    Directory path



```

### `$ ./cli dir lost -h`

```shell
invalid command: lost


```

### `$ ./cli file edit`

```shell
missing required argument: PATH
usage: cli file edit PATH


```

### `$ ./cli file edit -h`

```shell
cli file edit - Edit the file

Usage:
  cli file edit PATH
  cli file edit --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  PATH
    Path to file



```

### `$ ./cli file edit filename`

```shell
# this file is located in 'src/file_edit_command.sh'
# code for 'cli file edit' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[path]} = filename


```



