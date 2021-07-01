# YAML Example

This example was generated with:

    $ bashly init
    $ bashly add yaml
    $ bashly generate

Running the `bashly add yaml` command simply adds the [src/lib/yaml.sh](src/lib.yaml.sh) file, which provides functions for reading YAML files.

See the [src/root_command.sh](src/root_command.sh) for usage example.

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

## Generated script output

```shell
$ ./yaml -h

yaml - Sample application that uses the YAML functions

Usage:
  yaml FILENAME [VARIABLE] [options]
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



$ ./yaml settings.yml

environment="production"
server_port="3000"
server_host="http://localhost:3000"


$ ./yaml settings.yml --prefix config_

config_environment="production"
config_server_port="3000"
config_server_host="http://localhost:3000"


$ ./yaml settings.yml server_port

server_port=3000


```



