# Default Forced Command Example

Demonstrates how to set a command as the default command, that also rune when
it is executed without arguments, instead of showing the standard usage text.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: tester
help: Sample application that uses the forced default command option
version: 0.1.0

commands:
- name: all
  help: Run all tests

  # By setting `default: force`, it will be executed when the command line is
  # not recognized, and when it is empty.
  default: force

- name: only
  help: Run only specific tests
  args:
  - name: search
    required: true
    help: File pattern of tests to run
````



## Output

### `$ ./tester -h`

````shell
tester - Sample application that uses the forced default command option

Usage:
  tester [COMMAND]
  tester [COMMAND] --help | -h
  tester --version | -v

Commands:
  all    Run all tests (default)
  only   Run only specific tests

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./tester`

````shell
# This file is located at 'src/all_command.sh'.
# It contains the implementation for the 'tester all' command.
# The code you write here will be wrapped by a function named 'tester_all_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./tester all`

````shell
# This file is located at 'src/all_command.sh'.
# It contains the implementation for the 'tester all' command.
# The code you write here will be wrapped by a function named 'tester_all_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./tester all -h`

````shell
tester all - Run all tests

Usage:
  tester [all]
  tester all --help | -h

Options:
  --help, -h
    Show this help



````

### `$ ./tester only one`

````shell
# This file is located at 'src/only_command.sh'.
# It contains the implementation for the 'tester only' command.
# The code you write here will be wrapped by a function named 'tester_only_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[search]} = one


````



