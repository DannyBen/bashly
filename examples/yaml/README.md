# YAML Example

Demonstrates how to add functions to read YAML files.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add yaml
$ bashly generate
# ... now edit src/root_command.sh ...
$ bashly generate
```

Running the `bashly add yaml` command simply adds the [src/lib/yaml.sh]
(src/lib/yaml.sh) file, which provides functions for reading YAML files.

See the [src/root_command.sh](src/root_command.sh) for usage example.


<!-- include: settings.yml src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: yaml
help: Sample application that uses the YAML functions
version: 0.1.0

args:
- name: filename
  required: true
  help: The YAML file to read
- name: variable
  help: Show only this variable

flags:
- long: --prefix
  short: -p
  arg: prefix

examples:
- yaml settings.yml
- yaml settings.yml --prefix config_
- yaml settings.yml server_port
```

## `settings.yml`

```yaml
---
# Sample YAML file
environment: production

server:
  port: 3000
  host: 'http://localhost:3000'

```

## `src/root_command.sh`

```bash
filename=${args[filename]:-}
variable=${args[variable]:-}
prefix=${args[--prefix]:-}

if [[ $variable ]]; then
  eval "$(yaml_load "$filename" "$prefix")"
  value=${!variable}

  if [[ $value ]]; then
    echo "$variable=$value"
  else
    echo "variable not found: $variable"
  fi

else
  yaml_load "$filename" "$prefix"

fi
```


## Generated script output

### `$ ./yaml -h`

```shell
yaml - Sample application that uses the YAML functions

Usage:
  yaml FILENAME [VARIABLE] [OPTIONS]
  yaml --help | -h
  yaml --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --prefix, -p PREFIX


Arguments:
  FILENAME
    The YAML file to read

  VARIABLE
    Show only this variable

Examples:
  yaml settings.yml
  yaml settings.yml --prefix config_
  yaml settings.yml server_port



```

### `$ ./yaml settings.yml`

```shell
environment="production"
server_port="3000"
server_host="http://localhost:3000"


```

### `$ ./yaml settings.yml --prefix config_`

```shell
config_environment="production"
config_server_port="3000"
config_server_host="http://localhost:3000"


```

### `$ ./yaml settings.yml server_port`

```shell
server_port=3000


```



