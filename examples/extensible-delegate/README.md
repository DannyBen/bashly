# Extensible Delegate Command Example

Demonstrates how to configure an external delegate command that will be called (with all the arguments) whenever an unknown command is invoked.

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
  short: p
  help: Push to my repository

- name: pull
  short: l
  help: Pull from my repository
```

## Generated script output

```shell
$ ./mygit

mygit - Sample application that delegates unknown commands to a different executable

Usage:
  mygit [command]
  mygit [command] --help | -h
  mygit --version | -v

Commands:
  push   Push to my repository
  pull   Pull from my repository



$ ./mygit push

# this file is located in 'src/push_command.sh'
# code for 'mygit push' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


$ ./mygit rm some-file-that-doesnt-exist

fatal: pathspec 'some-file-that-doesnt-exist' did not match any files


```



