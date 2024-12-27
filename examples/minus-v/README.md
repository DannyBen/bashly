# Overriding `-v` and `-h`

Demonstrates how the `-h` and `-v` flags can be used in your script, without
colliding with `--version` and `--help`.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: cli
help: Example that replaces the default behavior of -v and -h
version: 0.1.0

flags:
- long: --verbose
  # Normally, the `-v` flag is used as a short flag for `--version`
  # Whenever you define such a flag in your script, the generated script
  # will respect your request, and avoid using `-v` as a `--version` shortcut.
  short: -v
  help: Show verbose output

- long: --host
  # The same applies to `-h` (which is otherwise short for `--help`)
  short: -h
  arg: host
  help: Host address
````



## Output

### `$ ./cli`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'cli' command.
# The code you write here will be wrapped by a function named 'cli_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./cli --help`

````shell
cli - Example that replaces the default behavior of -v and -h

Usage:
  cli [OPTIONS]
  cli --help
  cli --version

Options:
  --verbose, -v
    Show verbose output

  --host, -h HOST
    Host address

  --help
    Show this help

  --version
    Show version number



````

### `$ ./cli --version`

````shell
0.1.0


````

### `$ ./cli -h`

````shell
--host requires an argument: --host, -h HOST


````

### `$ ./cli -v`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'cli' command.
# The code you write here will be wrapped by a function named 'cli_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--verbose]} = 1


````

### `$ ./cli -h localhost -v`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'cli' command.
# The code you write here will be wrapped by a function named 'cli_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--host]} = localhost
- ${args[--verbose]} = 1


````



