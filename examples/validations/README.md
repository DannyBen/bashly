# Validations Example

Demonstrates how to add validation functions to arguments and flag arguments.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add validations
$ bashly generate
```

Running the `bashly add validations` command simply adds the
[src/lib/validations](src/lib/validations) folder, which includes some built in
validation functions. You can add custom function by adding a function that
starts with `validate_`. Thee functions must return a string on validation
failure, or an empty string on success.

-----

## `bashly.yml`

````yaml
name: validate
help: Sample application demonstrating validations
version: 0.1.0

commands:
- name: calc
  help: Add two numbers

  args:
  - name: first
    help: First number
    required: true

    # Specify a validation function.
    # Bashly will look for a function named `validate_integer` in your
    # script, you can use any name as long as it has a matching function.
    validate: integer
  - name: second
    help: Second number
    validate: integer

  flags:
  - long: --save
    arg: path
    help: Save the result to a file

    # Validations also work on flags (when they have arguments)
    validate: file_exists

- name: build
  environment_variables:
  - name: build_dir
    help: Path to the build directory
    default: release

    # Validations also work on environment variables
    validate: dir_exists
````



## Output

### `$ ./validate calc 1 2 --save README.md`

````shell
# This file is located at 'src/calc_command.sh'.
# It contains the implementation for the 'validate calc' command.
# The code you write here will be wrapped by a function named 'validate_calc_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[first]} = 1
- ${args[--save]} = README.md
- ${args[second]} = 2


````

### `$ ./validate calc A`

````shell
validation error in FIRST:
must be an integer


````

### `$ ./validate calc 1 B`

````shell
validation error in SECOND:
must be an integer


````

### `$ ./validate calc 1 2 --save no-such-file.txt`

````shell
validation error in --save PATH:
must be an existing file


````

### `$ ./validate build`

````shell
validation error in environment variable BUILD_DIR:
must be an existing directory


````

### `$ BUILD_DIR=src ./validate build`

````shell
# This file is located at 'src/build_command.sh'.
# It contains the implementation for the 'validate build' command.
# The code you write here will be wrapped by a function named 'validate_build_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none

environment variables:
- $BUILD_DIR = src


````



