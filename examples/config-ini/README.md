# Config Example

Demonstrates how to add functions for reading and writing INI files.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add config
$ bashly generate
# ... now edit all files in the src folder ...
$ bashly generate
```

Running the `bashly add config` command simply added the [src/lib/config.sh](src/lib/config.sh) file, which includes functions for reading and writing values from an INI file.

See the files in the [src](src) folder for usage examples.

<!-- include: config.ini src/get_command.sh src/list_command.sh src/set_command.sh -->

-----

## `bashly.yml`

```yaml
name: configly
help: Sample application that uses the config functions
version: 0.1.0

commands:
- name: set
  alias: s
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
  alias: g
  help: Read a value from the config file

  args:
  - name: key
    required: true
    help: Config key

  examples:
  - configly set hello

- name: list
  alias: l
  help: Show the entire config file
```

## `config.ini`

```ini
; comments are allowed
hello = world
bashly = works


```

## `src/get_command.sh`

```bash
# Using the standard library (lib/config.sh) to show a value from the config

key="${args[key]}"
if config_has_key "$key" ; then 
  config_get "$key"
else
  echo "No such key: $key"
fi

# Example of how to assign the config value to a variable:
# result=$(config_get "${args[key]}")
# echo $result


```

## `src/list_command.sh`

```bash
# Using the standard library (lib/config.sh) to show the entire config file
config_show

# Or to iterate through keys
for key in $(config_keys) ; do
  echo "$key === $(config_get "$key")"
done

```

## `src/set_command.sh`

```bash
# Using the standard library (lib/config.sh) to store a value to the config
config_set "${args[key]}" "${args[value]}"
echo "saved: ${args[key]} = ${args[value]}"

```


## Generated script output

### `$ ./configly -h`

```shell
configly - Sample application that uses the config functions

Usage:
  configly COMMAND
  configly [COMMAND] --help | -h
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



```

### `$ ./configly set hello world`

```shell
saved: hello = world


```

### `$ ./configly set bashly works`

```shell
saved: bashly = works


```

### `$ ./configly get hello`

```shell
world


```

### `$ ./configly get invalid_key`

```shell
No such key: invalid_key


```

### `$ ./configly list`

```shell
; comments are allowed
hello = world
bashly = works

hello === world
bashly === works


```



