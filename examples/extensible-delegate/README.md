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

````yaml
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
````



## Output

### `$ ./mygit`

````shell
mygit - Sample application that delegates unknown commands to a different executable

Usage:
  mygit COMMAND
  mygit [COMMAND] --help | -h
  mygit --version | -v

Commands:
  push   Push to my repository
  pull   Pull from my repository



````

### `$ ./mygit push`

````shell
# This file is located at 'src/push_command.sh'.
# It contains the implementation for the 'mygit push' command.
# The code you write here will be wrapped by a function named 'mygit_push_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./mygit rm some-file-that-doesnt-exist`

````shell
fatal: pathspec 'some-file-that-doesnt-exist' did not match any files


````



