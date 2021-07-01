# Docker Example

Demonstrates how to define deeply nested commands, similar to the docker cli (`docker container run`, `docker image ls`, etc.).

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

```shell
$ ./docker

docker - Docker example

Usage:
  docker [command]
  docker [command] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands



$ ./docker -h

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



$ ./docker container

docker container - Container commands

Shortcut: c*

Usage:
  docker container [command]
  docker container [command] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



$ ./docker container run -h

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



$ ./docker container run

missing required argument: IMAGE
usage: docker container run IMAGE


$ ./docker container run alpine

# this file is located in 'src/container_run_command.sh'
# code for 'docker container run' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[image]} = alpine


$ ./docker con

docker container - Container commands

Shortcut: c*

Usage:
  docker container [command]
  docker container [command] --help | -h

Commands:
  run    Run a container
  stop   Stop a container



$ ./docker image

docker image - Image commands

Shortcut: i*

Usage:
  docker image [command]
  docker image [command] --help | -h

Commands:
  ls   Show all images



$ ./docker image ls

# this file is located in 'src/image_ls_command.sh'
# code for 'docker image ls' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


$ ./docker i l

# this file is located in 'src/image_ls_command.sh'
# code for 'docker image ls' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```



