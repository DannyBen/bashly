# Commands Expose Example

Demonstrates how to show the summary help of subcommands in the `--help`
message of their parent command.

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

commands:
- name: init
  help: Start a new project

- name: config
  help: Config management commands

  # Setting `expose` to true will show the summary of the subcommands when
  # using `cli --help` for the parent command. In this case, `config edit` and
  # `config show` will be displayed.
  expose: true
  commands:
  - name: edit
    help: Edit config file
  - name: show
    help: Show config file

- name: server
  help: Server management commands
  
  # Setting `expose` to `always` will also show the summary of the subcommands
  # when running `cli` without arguments.
  expose: always

  # Adding a `group` works well with `expose`. In this case, `server start` and
  # `server stop` will be listed under `Cluster Commands`.
  group: Cluster

  commands:
  - name: start
    help: Start the server
  - name: stop
    help: Stop the server

- name: container
  alias: c
  help: Container management commands
  expose: true
  group: Cluster
  commands:
  - name: exec
    help: Run a command in the container
  - name: down
    help: Terminate a container
```



## Generated script output

### `$ ./cli`

```shell
cli

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  init             Start a new project
  config           Config management commands

Cluster Commands:
  server           Server management commands
  server start     Start the server
  server stop      Stop the server
  container        Container management commands



```

### `$ ./cli -h`

```shell
cli

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  init             Start a new project
  config           Config management commands
  config edit      Edit config file
  config show      Show config file

Cluster Commands:
  server           Server management commands
  server start     Start the server
  server stop      Stop the server
  container        Container management commands
  container exec   Run a command in the container
  container down   Terminate a container

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



```



