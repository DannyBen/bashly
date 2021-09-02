# Docker Example

Demonstrates how to define deeply nested commands, similar to the docker cli
(`docker container run`, `docker image ls`, etc.).

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: docker
help: Docker example
version: 0.1.0

commands:
- name: container
  short: c*
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
  short: i*
  help: Image commands

  commands:
  - name: ls
    short: l
    help: Show all images
```



## Generated script output

### `$ ./docker`

```shell
docker - Docker example

Usage:
  docker [command]
  docker [command] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands



```

### `$ ./docker -h`

```shell
docker - Docker example

Usage:
  docker [command]
  docker [command] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



```

### `$ ./docker container`

```shell
docker container - Container commands

Shortcut: c*

Usage:
  docker container [command]
  docker container [command] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



```

### `$ ./docker container run -h`

```shell
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



```

### `$ ./docker container run`

```shell
missing required argument: IMAGE
usage: docker container run IMAGE


```

### `$ ./docker container run alpine`

```shell
# this file is located in 'src/container_run_command.sh'
# code for 'docker container run' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[image]} = alpine


```

### `$ ./docker con`

```shell
docker container - Container commands

Shortcut: c*

Usage:
  docker container [command]
  docker container [command] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



```

### `$ ./docker image`

```shell
docker image - Image commands

Shortcut: i*

Usage:
  docker image [command]
  docker image [command] --help | -h

Commands:
  ls   Show all images



```

### `$ ./docker image ls`

```shell
# this file is located in 'src/image_ls_command.sh'
# code for 'docker image ls' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./docker i l`

```shell
# this file is located in 'src/image_ls_command.sh'
# code for 'docker image ls' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```



