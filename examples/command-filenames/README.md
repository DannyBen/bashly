# Command Filenames Example

Demonstrates how to specify custom filenames for command source files.
This is useful for scripts with many commands, in case you wish to organize
your source files in sub-folders.

Note that the specified path is relative to the `sec` folder.

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
help: Demonstrate custom command filenames
version: 0.1.0

commands:
- name: dir
  alias: d
  help: Directory commands

  commands:
  - name: list
    help: Show files in the directory
    
    # Define a custom filename for this command source.
    # This is relative to the `src` directory, and sub-directories will be
    # created as needed.
    filename: dir_commands/list.sh

  - name: remove
    help: Remove directory
    filename: dir_commands/remove.sh

- name: file
  alias: f
  help: File commands

  commands:
  - name: show
    help: Show file contents
    filename: file_commands/show.sh

  - name: edit
    help: Edit the file
    filename: file_commands/edit.sh
```



## Generated script output

### `$ ./cli`

```shell
cli - Demonstrate custom command filenames

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
cli - Demonstrate custom command filenames

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

### `$ ./cli dir list`

```shell
# this file is located in 'src/dir_commands/list.sh'
# code for 'cli dir list' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```



