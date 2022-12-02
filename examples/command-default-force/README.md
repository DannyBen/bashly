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

```yaml
name: tester
help: Sample application that uses the forced default command option
version: 0.1.0

commands:
- name: all
  help: Run all tests

  # By setting the `default: force`, it will be executed when the command line
  # is not recognized, and when it is empty.
  default: force

- name: only
  help: Run only specific tests
  args:
  - name: search
    required: true
    help: File pattern of tests to run
```



## Generated script output

### `$ ./tester -h`

```shell
tester - Sample application that uses the forced default command option

Usage:
  tester COMMAND
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



```

### `$ ./tester`

```shell
# this file is located in 'src/all_command.sh'
# code for 'tester all' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./tester all`

```shell
# this file is located in 'src/all_command.sh'
# code for 'tester all' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./tester all -h`

```shell
tester all - Run all tests

Usage:
  tester all
  tester all --help | -h

Options:
  --help, -h
    Show this help



```

### `$ ./tester only one`

```shell
# this file is located in 'src/only_command.sh'
# code for 'tester only' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[search]} = one


```



