# Docker Example

Demonstrates how to define deeply nested commands, similar to the docker cli
(`docker container run`, `docker image ls`, etc.).

In addition, this example shows the use of global flags, where flags defined 
at the root level, become available to all nested commands, like the`--debug`
flag in `docker --debug ps --all`.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: docker
help: Docker example
version: 0.1.0

# Since we have a `commands` section below, these flags will be considered
# "global flags" and available to all sub-commands.
flags:
- long: --debug
  short: -d
  help: Enable debug mode

commands:
- name: container
  alias: c*
  help: Container commands

  commands:
  - name: run
    help: Run a container
    args:
    - name: image
      help: Image name
      required: true

  - name: stop
    help: Stop a container
    args:
    - name: container
      help: Container name
      required: true

- name: image
  alias: i*
  help: Image commands

  commands:
  - name: ls
    alias: l
    help: Show all images

- name: ps
  help: List containers

  flags:
  - long: --all
    short: -a
    help: Show all containers
````



## Output

### `$ ./docker`

````shell
docker - Docker example

Usage:
  docker [OPTIONS] COMMAND
  docker [COMMAND] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands
  ps          List containers



````

### `$ ./docker -h`

````shell
docker - Docker example

Usage:
  docker [OPTIONS] COMMAND
  docker [COMMAND] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands
  ps          List containers

Global Options:
  --debug, -d
    Enable debug mode

  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./docker container`

````shell
docker container - Container commands

Alias: c*

Usage:
  docker container COMMAND
  docker container [COMMAND] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



````

### `$ ./docker container run -h`

````shell
docker container run - Run a container

Usage:
  docker container run IMAGE
  docker container run --help | -h

Options:
  --help, -h
    Show this help

Arguments:
  IMAGE
    Image name



````

### `$ ./docker container run`

````shell
missing required argument: IMAGE
usage: docker container run IMAGE


````

### `$ ./docker -d container run alpine`

````shell
# This file is located at 'src/container_run_command.sh'.
# It contains the implementation for the 'docker container run' command.
# The code you write here will be wrapped by a function named 'docker_container_run_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--debug]} = 1
- ${args[image]} = alpine


````

### `$ ./docker con`

````shell
docker container - Container commands

Alias: c*

Usage:
  docker container COMMAND
  docker container [COMMAND] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



````

### `$ ./docker image`

````shell
docker image - Image commands

Alias: i*

Usage:
  docker image COMMAND
  docker image [COMMAND] --help | -h

Commands:
  ls   Show all images



````

### `$ ./docker image ls`

````shell
# This file is located at 'src/image_ls_command.sh'.
# It contains the implementation for the 'docker image ls' command.
# The code you write here will be wrapped by a function named 'docker_image_ls_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./docker i l`

````shell
# This file is located at 'src/image_ls_command.sh'.
# It contains the implementation for the 'docker image ls' command.
# The code you write here will be wrapped by a function named 'docker_image_ls_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./docker --debug ps --all`

````shell
# This file is located at 'src/ps_command.sh'.
# It contains the implementation for the 'docker ps' command.
# The code you write here will be wrapped by a function named 'docker_ps_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--all]} = 1
- ${args[--debug]} = 1


````



