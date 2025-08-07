# Command Line Manipulation

Demonstrates how to read or override the raw input command line. 

Note that this is *not needed nor recommended* under most circumstances - it 
is provided as an edge case utility.

This example was generated with:

```bash
$ bashly init --minimal
$ bashly add hooks
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/initialize.sh to match the example ...
# ... now edit src/before.sh to match the example ...
$ bashly generate
```

<!-- include: src/initialize.sh src/before.sh -->

-----

## `bashly.yml`

````yaml
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
````

## `src/initialize.sh`

````bash
echo "==[ Initialize Called ]=="

# Override the command line completely if the first argument is 'debug'
if [[ "${command_line[0]:-""}" = "debug" ]]; then
  command_line=("modified" "args" "--force")
fi

````

## `src/before.sh`

````bash
echo "==[ Before Hook Called ]=="

echo "Read-only copy of the raw input array: ${input[*]}"
inspect_args

````


## Output

### `$ ./download `

````shell
==[ Initialize Called ]==
missing required argument: SOURCE
usage: download SOURCE [TARGET] [OPTIONS]


````

### `$ ./download debug`

````shell
==[ Initialize Called ]==
==[ Before Hook Called ]==
Read-only copy of the raw input array: modified args --force
args:
- ${args[--force]} = 1
- ${args[source]} = modified
- ${args[target]} = args
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'download' command.
# The code you write here will be wrapped by a function named 'download_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--force]} = 1
- ${args[source]} = modified
- ${args[target]} = args
==[ After Hook Called ]==


````



