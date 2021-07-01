Sub-Commands Example
==================================================

This example was generated with:

    $ bashly init
    $ bashly generate

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application with nested commands
version: 0.1.0

commands:
- name: dir
  short: d
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
  short: f
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

```shell
$ ./cli

cli - Sample application with nested commands

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  dir    Directory commands
  file   File commands



$ ./cli -h

cli - Sample application with nested commands

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  dir    Directory commands
  file   File commands

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



$ ./cli dir

cli dir - Directory commands

Shortcut: d

Usage:
  cli dir [command]
  cli dir [command] --help | -h

Commands:
  list     Show files in the directory
  remove   Remove directory



$ ./cli file

cli file - File commands

Shortcut: f

Usage:
  cli file [command]
  cli file [command] --help | -h

Commands:
  show   Show file contents
  edit   Edit the file



$ ./cli dir -h

cli dir - Directory commands

Shortcut: d

Usage:
  cli dir [command]
  cli dir [command] --help | -h

Commands:
  list     Show files in the directory
  remove   Remove directory

Options:
  --help, -h
    Show this help



$ ./cli file -h

cli file - File commands

Shortcut: f

Usage:
  cli file [command]
  cli file [command] --help | -h

Commands:
  show   Show file contents
  edit   Edit the file

Options:
  --help, -h
    Show this help



$ ./cli dir list

missing required argument: PATH
usage: cli dir list PATH


$ ./cli dir list -h

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



$ ./cli file edit

missing required argument: PATH
usage: cli file edit PATH


$ ./cli file edit -h

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



$ ./cli file edit filename

# this file is located in 'src/file_edit_command.sh'
# code for 'cli file edit' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[path]} = filename


```



