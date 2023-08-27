# Command Function Example

Demonstrates how to specify a custom function name for commands. This option
is used internally by bashly to determine the names of the functions for any
command.

Normally, this should not be modified, but in some use cases it might be
necessary. One such use case, is when you have two commands that naturally
evaluate to the same function name.

Assuming your CLI responds to both:

- `cli container-start`
- `cli container start`

In this case, the internal function names will both be `cli_container_start`, 
which might be undesirable. This is where the `function` directive comes in
handy.

Also note that the name specified here is just used as a base name. Bashly will
generate several functions from it:

- `cli_container_start_command`
- `cli_container_start_usage`
- and possibly more

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
help: Sample application with custom function names
version: 0.1.0

commands:
- name: container-start
  help: Start a new container (deprecated)

  # Override the name of the internal functions bashly uses. This is needed
  # in this case since the command `container-start` and the nested command
  # `container start` will have the same underlying function name otherwise.
  function: deprecated_container_start
  footer: This command is deprecated, use 'container start' instead

- name: container
  help: Container commands
  commands:
  - name: start
    help: Start a new container
````



## Output

### `$ ./cli`

````shell
cli - Sample application with custom function names

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  container-start   Start a new container (deprecated)
  container         Container commands



````

### `$ ./cli -h`

````shell
cli - Sample application with custom function names

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  container-start   Start a new container (deprecated)
  container         Container commands

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./cli container-start --help`

````shell
cli container-start - Start a new container (deprecated)

Usage:
  cli container-start
  cli container-start --help | -h

Options:
  --help, -h
    Show this help

This command is deprecated, use 'container start' instead



````

### `$ ./cli container start --help`

````shell
cli container start - Start a new container

Usage:
  cli container start
  cli container start --help | -h

Options:
  --help, -h
    Show this help



````



