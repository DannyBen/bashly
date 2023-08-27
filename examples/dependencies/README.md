# Dependencies Example

Demonstrates how to require your script's user to have certain dependencies
(commands) installed prior to using your script.

This example was generated with:

```bash
$ bashly init
$ bashly add colors
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
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

  # Dependencies can also be defined as a hash of 'command: message' pairs.
  # The message can use colors from the colors library (bashly add colors).
  dependencies:
    mini-docker: install with $(green gem install mini-docker)
    docker: visit https://docker.com for more information
````



## Output

### `$ ./cli download`

````shell
missing dependency: shmurl


````

### `$ ./cli upload`

````shell
missing dependency: mini-docker
install with gem install mini-docker


````



