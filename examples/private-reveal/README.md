# Private Reveal Example

Demonstrates how to allow users to reveal any private commands, flags and
environment variables.

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
name: cli
help: Sample application
version: 0.1.0

# All elements with `private: true` in this configuration will be hidden
# unless the environment variable SHOW_PELASE is set (as defined
# in ../settings.yml)

environment_variables:
- name: secret
  help: Set secret key
  private: true

flags:
- long: --debug
  help: Enable debug mode
  private: true

commands:
- name: admin
  help: Admin operations
  expose: true

  commands:
  - name: list
    help: List connected devices    
  - name: reboot
    help: Reboot
    private: true
````

## `settings.yml`

````yaml
# When using private commands, flags, or environment variables, you may set 
# this option to a name of an environment variable that, if set, will reveal
# all the private elements in the usage texts, as if they were public.
private_reveal_key: SHOW_PLEASE
````


## Output

### `$ ./cli`

````shell
cli - Sample application

Usage:
  cli [OPTIONS] COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  admin          Admin operations



````

### `$ ./cli -h`

````shell
cli - Sample application

Usage:
  cli [OPTIONS] COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  admin          Admin operations
  admin list     List connected devices

Global Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./cli admin -h`

````shell
cli admin - Admin operations

Usage:
  cli admin COMMAND
  cli admin [COMMAND] --help | -h

Commands:
  list     List connected devices

Options:
  --help, -h
    Show this help



````

### `$ export SHOW_PLEASE=1`

````shell


````

### `$ ./cli -h`

````shell
cli - Sample application

Usage:
  cli [OPTIONS] COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  admin          Admin operations
  admin list     List connected devices

Global Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./cli admin -h`

````shell
cli admin - Admin operations

Usage:
  cli admin COMMAND
  cli admin [COMMAND] --help | -h

Commands:
  list     List connected devices

Options:
  --help, -h
    Show this help



````



