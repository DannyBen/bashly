# Environment Variables Example

Demonstrates how to specify that your script supports (or requires) certain environment variables. This can be configured at any command level (root command or sub commands).

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
  short: v
  help: Verify your user

  # This option belongs to the `verify` command and will appear in its help
  # message. In addition, setting `required: true` will halt the script's 
  # execution with a friendly error message, unless the variable is set.
  environment_variables:
  - name: my_secret
    help: Your secret
    required: true
```

## Generated script output

### `$ ./cli`

```shell
cli - Sample application that requires environment variables

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  verify   Verify your user



```

### `$ ./cli -h`

```shell
cli - Sample application that requires environment variables

Usage:
  cli [command]
  cli [command] --help | -h
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

Shortcut: v

Usage:
  cli verify
  cli verify --help | -h

Options:
  --help, -h
    Show this help

Environment Variables:
  MY_SECRET (required)
    Your secret



```

### `$ ./cli verify`

```shell
missing required environment variable: MY_SECRET


```

### `$ ./cli verify`

```shell
missing required environment variable: MY_SECRET


```



