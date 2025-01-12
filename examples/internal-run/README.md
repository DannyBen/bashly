# Internal Run Example

This example demonstrates how to use the `run` function to call commands
internally, using the exact same syntax as a user would in the CLI. This
approach can be useful for chaining commands or reusing logic without
duplicating code.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
# ... now edit the generated command files to match the example ...
$ bashly generate
```

Note that while this pattern of calling `run` internally is supported, you may
want to consider using [lib functions]
instead, for a more robust codebase.

While this pattern of calling run internally is supported, you may want to
consider using [lib functions](https://bashly.dannyb.co/usage/writing-your-scripts/#adding-common-functions)
instead. lib functions can help create a more robust and maintainable codebase
by centralizing reusable logic.

<!-- include: src/build_command.sh -->
<!-- include: src/test_command.sh -->
<!-- include: src/deploy_command.sh -->

-----

## `bashly.yml`

````yaml
name: cli
help: Internal run test
version: 0.1.0

commands:
- name: build
  help: Build code
  args:
  - name: env
    help: Build environment
    default: development
    allowed: [development, production]

- name: test
  help: Test code
  flags:
  - long: --full
    help: Run all tests

- name: deploy
  help: Deploy code
  flags:
  - long: --build
    help: Build before deploying
  - long: --test
    help: Test before deploying
````

## `src/build_command.sh`

````bash
echo "BUILD complete"
inspect_args
echo
````


## Output

### `$ ./cli -h`

````shell
cli - Internal run test

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  build    Build code
  test     Test code
  deploy   Deploy code

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./cli deploy -h`

````shell
cli deploy - Deploy code

Usage:
  cli deploy [OPTIONS]
  cli deploy --help | -h

Options:
  --build
    Build before deploying

  --test
    Test before deploying

  --help, -h
    Show this help



````

### `$ ./cli deploy --build --test`

````shell
BUILD complete
args:
- ${args[env]} = production

TEST complete
args:
- ${args[--full]} = 1

DEPLOY complete
args:
- ${args[--full]} = 1


````



