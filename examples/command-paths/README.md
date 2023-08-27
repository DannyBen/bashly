# Command Paths Example

Demonstrates how to globally change the path used for command files and instruct
bashly to read/write command files to nested sub-directories.

This is useful for scripts with many commands,

Note that the specified path is relative to the `src` folder.

See also: [Command Filenames Example](/examples/command-filenames#readme)

This example was generated with:

```bash
$ bashly init
$ bashly add settings
# ... now edit settings.yml to match the example ...
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

<!-- include: settings.yml -->

-----

## `bashly.yml`

````yaml
name: docker
help: Docker example with nested command filenames
version: 0.1.0

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

## `settings.yml`

````yaml
# The path to use for command files, relative to source_dir
# When set to nil (~), command files will be placed directly under source_dir
# When set to any other string, command files will be placed under this
# directory, and each command will get its own subdirectory

# commands_dir: ~
commands_dir: commands

````


## Output

### `$ ./docker`

````shell
docker - Docker example with nested command filenames

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
docker - Docker example with nested command filenames

Usage:
  docker [OPTIONS] COMMAND
  docker [COMMAND] --help | -h
  docker --version | -v

Commands:
  container   Container commands
  image       Image commands
  ps          List containers

Options:
  --debug, -d
    Enable debug mode

  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./docker container run alpine`

````shell
# this file is located in 'src/commands/container/run.sh'
# code for 'docker container run' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[image]} = alpine


````

### `$ ls -R src`

````shell
src:
bashly.yml
commands

src/commands:
container
image
ps.sh

src/commands/container:
run.sh
stop.sh

src/commands/image:
ls.sh


````



