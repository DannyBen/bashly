# Environment Variables Example

Demonstrates how to specify that your script supports (or requires) certain
environment variables. This can be configured at any command level(root command
or sub commands).

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
# ... now edit src/verify_command.sh ...
$ bashly generate
```

<!-- include: src/verify_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application that requires environment variables
version: 0.1.0

# This option adds usage text to the help message in the generated script.
environment_variables:
- name: api_key
  help: Set your API key

commands:
- name: verify
  alias: v
  help: Verify your user

  # This option belongs to the `verify` command and will appear in its help
  # message.
  environment_variables:
  # Setting `required: true` will halt the script's execution with a
  # friendly error message, unless the variable is set.
  - name: my_secret
    help: Your secret
    required: true
  
  # Using the `default: value` option will cause the value to variable to be 
  # set if it is not provided by the user.
  - name: environment
    help: One of development, production or test
    default: development
```

## `src/verify_command.sh`

```bash
echo "# this file is located in 'src/verify_command.sh'"
echo "# code for 'cli verify' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

echo "environment:"
echo "- API_KEY=${API_KEY:-}"
echo "- ENVIRONMENT=${ENVIRONMENT:-}"
echo "- MY_SECRET=${MY_SECRET:-}"

```


## Generated script output

### `$ ./cli`

```shell
cli - Sample application that requires environment variables

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  verify   Verify your user



```

### `$ ./cli -h`

```shell
cli - Sample application that requires environment variables

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  verify   Verify your user

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  API_KEY
    Set your API key



```

### `$ ./cli verify -h`

```shell
cli verify - Verify your user

Alias: v

Usage:
  cli verify
  cli verify --help | -h

Options:
  --help, -h
    Show this help

Environment Variables:
  MY_SECRET (required)
    Your secret

  ENVIRONMENT
    One of development, production or test
    Default: development



```

### `$ ./cli verify`

```shell
missing required environment variable: MY_SECRET


```

### `$ MY_SECRET="there is no spoon" ./cli verify`

```shell
# this file is located in 'src/verify_command.sh'
# code for 'cli verify' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none
environment:
- API_KEY=
- ENVIRONMENT=development
- MY_SECRET=there is no spoon


```

### `$ ENVIRONMENT=production MY_SECRET=safe-with-me ./cli verify`

```shell
# this file is located in 'src/verify_command.sh'
# code for 'cli verify' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none
environment:
- API_KEY=
- ENVIRONMENT=production
- MY_SECRET=safe-with-me


```



