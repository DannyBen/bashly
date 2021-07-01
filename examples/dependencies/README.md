# Dependencies Example

Demonstrates how to require your script's user to have certain dependencies (commands) installed prior to using your script.

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application that requires dependencies
version: 0.1.0

commands:
- name: download
  help: Download something

  # By defining dependencies, the generated script will be halted (with a
  # friendly error message) unless all of these commands exist in the host
  # system.
  dependencies:
  - git
  - curl
  - shmurl

- name: upload
  help: Upload something
```

## Generated script output

```shell
$ ./cli download

# this file is located in 'src/download_command.sh'
# code for 'cli download' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


$ ./cli upload

# this file is located in 'src/upload_command.sh'
# code for 'cli upload' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```



