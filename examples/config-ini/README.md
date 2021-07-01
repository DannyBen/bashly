# Config Example

This example was generated with:

    $ bashly init
    $ bashly add config
    $ bashly generate

Running the `bashly add config` command simply added the [src/lib/config.sh](src/lib/config.sh) file, which includes functions for reading and writing values from an INI file.

See the files in the [src](src) folder for usage examples.

-----

## `bashly.yml`

```yaml
name: configly
help: Sample application that uses the config functions
version: 0.1.0

commands:
- name: set
  short: s
  help: Save a value in the config file

  args:
  - name: key
    required: true
    help: Config key
  - name: value
    required: true
    help: Config value

  examples:
  - configly set hello world

- name: get
  short: g
  help: Read a value from the config file

  args:
  - name: key
    required: true
    help: Config key

  examples:
  - configly set hello

- name: list
  short: l
  help: Show the entire config file
```

## Generated script output

```shell
$ ./configly -h

configly - Sample application that uses the config functions

Usage:
  configly [command]
  configly [command] --help | -h
  configly --version | -v

Commands:
  set    Save a value in the config file
  get    Read a value from the config file
  list   Show the entire config file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



$ ./configly set hello world

saved: hello = world


$ ./configly set bashly works

saved: bashly = works


$ ./configly get hello

world


$ ./configly get invalid_key

No such key: invalid_key


$ ./configly list

; comments are allowed
hello = world
bashly = works

hello === world
bashly === works


```



