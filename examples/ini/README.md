# INI Example

Demonstrates how to add functions for reading and writing INI files.

Note that this is a low-level library that provides the reading and writing
functions for the [config library](https://github.com/DannyBen/bashly/tree/master/examples/config#readme).

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add ini
$ bashly generate
# ... now edit all files in the src folder ...
$ bashly generate
```

Running the `bashly add ini` command simply added the
[src/lib/ini.sh](src/lib/ini.sh) file, which includes functions for
reading and writing values from an INI file.

See the files in the [src](src) folder for usage examples.

<!-- include: config.ini src/get_command.sh src/list_command.sh src/set_command.sh src/del_command.sh -->

-----

## `bashly.yml`

````yaml
name: configly
help: Sample application that uses the config functions
version: 0.1.0

commands:
- name: list
  alias: l
  help: Show the entire config file

- name: get
  alias: g
  help: Read a value from the config file

  args:
  - name: key
    required: true
    help: Config key

  examples:
  - configly get hello
  - configly get user.name

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
  - configly set user.email me@example.com

- name: del
  alias: d
  help: Remove a value from the config file

  args:
  - name: key
    required: true
    help: Config key

  examples:
  - configly del hello
  - configly del user.name
````

## `config.ini`

````ini
; comments are allowed, sections are optional
hello = world
bashly = works

[options]
name = value for options.name
path = value for options.path

[user]
name = value for user.name
email = value for user.email

````

## `src/get_command.sh`

````bash
# Using the standard library (lib/ini.sh) to show a value from the config
ini_load config.ini

key="${args[key]:-}"
value=${ini[$key]:-}

if [[ "$value" ]]; then
  echo "$key = $value"
else
  echo "No such key: $key"
fi

````

## `src/list_command.sh`

````bash
# Using the standard library (lib/ini.sh) to show the entire config file
ini_load config.ini
ini_show

## Or iterate through keys manually
# for key in $(ini_keys); do 
#   echo "$key = ${ini[$key]}"
# done
````

## `src/set_command.sh`

````bash
# Using the standard library (lib/ini.sh) to store a value to the config
ini_load config.ini

key="${args[key]}"
value="${args[value]}"

ini["$key"]="$value"
ini_save saved.ini
cat saved.ini

````

## `src/del_command.sh`

````bash
# Using the standard library (lib/ini.sh) to delete a value from the config
ini_load config.ini

key="${args[key]}"
unset "ini[$key]"

ini_save saved.ini
cat saved.ini


````


## Output

### `$ ./configly -h`

````shell
configly - Sample application that uses the config functions

Usage:
  configly COMMAND
  configly [COMMAND] --help | -h
  configly --version | -v

Commands:
  list   Show the entire config file
  get    Read a value from the config file
  set    Save a value in the config file
  del    Remove a value from the config file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./configly set hello WORLD`

````shell
bashly = works
hello = WORLD

[options]
name = value for options.name
path = value for options.path

[user]
email = value for user.email
name = value for user.name


````

### `$ ./configly set user.name Megatron`

````shell
bashly = works
hello = world

[options]
name = value for options.name
path = value for options.path

[user]
email = value for user.email
name = Megatron


````

### `$ ./configly get hello`

````shell
hello = world


````

### `$ ./configly get user.name`

````shell
user.name = value for user.name


````

### `$ ./configly get invalid_key`

````shell
No such key: invalid_key


````

### `$ ./configly del user.email`

````shell
bashly = works
hello = world

[options]
name = value for options.name
path = value for options.path

[user]
name = value for user.name


````

### `$ ./configly list`

````shell
bashly = works
hello = world
options.name = value for options.name
options.path = value for options.path
user.email = value for user.email
user.name = value for user.name


````



