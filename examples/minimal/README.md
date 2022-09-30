# Minimal Example

This is the simplest "hello world" example.

This example was generated with:

```bash
$ bashly init --minimal
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: download
help: Sample minimal application without commands
version: 0.1.0

args:
- name: source
  required: true
  help: URL to download from
- name: target
  help: "Target filename (default: same as source)"

flags:
- long: --force
  short: -f
  help: Overwrite existing files

examples:
- download example.com
- download example.com ./output -f
```



## Generated script output

### `$ ./download`

```shell
missing required argument: SOURCE
usage: download SOURCE [TARGET] [OPTIONS]


```

### `$ ./download -h`

```shell
download - Sample minimal application without commands

Usage:
  download SOURCE [TARGET] [OPTIONS]
  download --help | -h
  download --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --force, -f
    Overwrite existing files

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Examples:
  download example.com
  download example.com ./output -f



```

### `$ ./download -v`

```shell
0.1.0


```

### `$ ./download somesource -f`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--force]} = 1
- ${args[source]} = somesource


```



