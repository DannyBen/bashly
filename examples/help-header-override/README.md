# Help Header Override Example

Demonstrates how to fully replace the header in the output of `--help`.

This is especially useful when incorporating ASCII art as your script's help
header.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
$ bashly generate

```

-----

## `bashly.yml`

````yaml
name: download
help: Sample minimal application without commands
version: 0.1.0

# Use bash code here directly or a function name that references code elsewhere.
help_header_override: |
  echo
  echo $' 888888b.                     888      888          '
  echo $' 888  "88b                    888      888          '
  echo $' 888  .88P                    888      888          '
  echo $' 8888888K.   8888b.  .d8888b  88888b.  888 888  888 '
  echo $' 888  "Y88b     "88b 88K      888 "88b 888 888  888 '
  echo $' 888    888 .d888888 "Y8888b. 888  888 888 888  888 '
  echo $' 888   d88P 888  888      X88 888  888 888 Y88b 888 '
  echo $' 8888888P"  "Y888888  88888P\' 888  888 888  "Y88888 '
  echo $'                                                888 '
  echo $'                                           Y8b d88P '
  echo $'                                            "Y88P"  '
  echo

args:
- name: source
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
````



## Output

### `$ ./download`

````shell
# This file is located at 'src/root_command.sh'.
# It contains the implementation for the 'download' command.
# The code you write here will be wrapped by a function named 'download_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./download --help`

````shell

 888888b.                     888      888          
 888  "88b                    888      888          
 888  .88P                    888      888          
 8888888K.   8888b.  .d8888b  88888b.  888 888  888 
 888  "Y88b     "88b 88K      888 "88b 888 888  888 
 888    888 .d888888 "Y8888b. 888  888 888 888  888 
 888   d88P 888  888      X88 888  888 888 Y88b 888 
 8888888P"  "Y888888  88888P' 888  888 888  "Y88888 
                                                888 
                                           Y8b d88P 
                                            "Y88P"  

Usage:
  download [SOURCE] [TARGET] [OPTIONS]
  download --help | -h
  download --version | -v

Options:
  --force, -f
    Overwrite existing files

  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Examples:
  download example.com
  download example.com ./output -f



````



