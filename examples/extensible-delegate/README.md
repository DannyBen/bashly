# Extensible Delegate Command Example

Demonstrates how to configure an external delegate command that will be called
(with all the arguments) whenever an unknown command is invoked.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: mygit
help: Sample application that delegates unknown commands to a different executable
version: 0.1.0

# Setting `extensible` to any string will delegate any unknown commands
# to this executable. 
# In this example, calling `mygit status` or `mygit log` will invoke the 
# respective `git status` and `git log` commands.
extensible: git

commands:
- name: push
  alias: p
  help: Push to my repository

- name: pull
  alias: l
  help: Pull from my repository
```



## Generated script output

### `$ ./mygit`

```shell
mygit - Sample application that delegates unknown commands to a different executable

Usage:
  mygit COMMAND
  mygit [COMMAND] --help | -h
  mygit --version | -v

Commands:
  push   Push to my repository
  pull   Pull from my repository



```

### `$ ./mygit push`

```shell
# this file is located in 'src/push_command.sh'
# code for 'mygit push' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./mygit rm some-file-that-doesnt-exist`

```shell
fatal: pathspec 'some-file-that-doesnt-exist' did not match any files


```



