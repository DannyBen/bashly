# Needy Flags Example

Demonstrates the use of needy flags that must be executed together.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: cli
help: Sample application to demonstrate the use of needy flags
version: 0.1.0

flags:
- long: --add
  short: -a
  arg: alias
  help: Alias to add
  # When using --add, --command and --target must also be provided
  needs: [--command, --target]

- long: --command
  short: -c
  arg: command
  help: Command for the alias
  # Note that this relationship is marked on both sides
  needs: [--add]

- long: --target
  short: -t
  arg: target
  help: Where to add the alias
  needs: [--add]
  allowed: [global, local]
````



## Output

### `$ ./cli -h`

````shell
cli - Sample application to demonstrate the use of needy flags

Usage:
  cli [OPTIONS]
  cli --help | -h
  cli --version | -v

Options:
  --add, -a ALIAS
    Alias to add
    Needs: --command, --target

  --command, -c COMMAND
    Command for the alias
    Needs: --add

  --target, -t TARGET
    Where to add the alias
    Allowed: global, local
    Needs: --add

  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./cli --add deploy`

````shell
--add requires --command


````

### `$ ./cli --add deploy --command 'git push'`

````shell
--add requires --target


````

### `$ ./cli --add deploy --command 'git push' --target local`

````shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--add]} = deploy
- ${args[--command]} = git push
- ${args[--target]} = local


````



