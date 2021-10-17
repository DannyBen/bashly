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

```yaml
name: calc
help: Sample application demonstrating validations
version: 0.1.0

commands:
- name: add
  short: a
  help: Add two numbers

  args:
  - name: first
    help: First number
    required: true

    # Specify one or more validation types (as string or array)
    # This validation will look for a function named `validate_integer` in your
    # script.
    validate: integer
  - name: second
    help: Second number

    # Using the array syntax, you can specify more than one validations
    validate:
      - integer

  flags:
  - long: --multiply
    short: -m
    arg: factor
    help: Multiply the result

    # Validations also work on flags (when they have arguments)
    validate: integer
```



## Generated script output

### `$ ./calc -h`

```shell
sh: 1: ./calc: not found


```



