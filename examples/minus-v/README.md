Example -v and -h override
==================================================

This example was generated with:

    $ bashly init --minimal
    $ bashly generate

-----

## `bashly.yml`

```yaml
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
```

## Generated script output

```shell
$ ./cli

# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args: none


$ ./cli --help

cli - Example that replaces the default behavior of -v and -h

Usage:
  cli [options]
  cli --help
  cli --version

Options:
  --help
    Show this help

  --version
    Show version number

  --verbose, -v
    Show verbose output

  --host, -h HOST
    Host address



$ ./cli --version

0.1.0


$ ./cli -h

--host requires an argument: --host, -h HOST


$ ./cli -v

# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--verbose]} = 1


$ ./cli -h localhost -v

# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--host]} = localhost
- ${args[--verbose]} = 1


```



