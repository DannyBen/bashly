# Help Command Example

Demonstrates how to add a `help` command to your script. This is only needed
if you prefer to have the `your-cli help COMMAND` syntax in addition to the 
natively supported `your-cli COMMAND --help` syntax.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
# ... now edit src/help_command.sh to match the example ...
$ bashly generate

```

<!-- include: src/help_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

environment_variables:
- name: api_key
  help: Set your API key

commands:
# Here we are adding the help command
- name: help
  alias: h
  help: Show help about a command
  args:
  - name: command
    help: Help subject

# The rest of this file is not important for the purpose of this example

- name: download
  alias: d
  help: Download a file

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

  examples:
  - cli download example.com
  - cli download example.com ./output -f

  environment_variables:
  - name: default_target_location
    help: Set the default location to download to

- name: upload
  alias: u
  help: Upload a file
  args:
  - name: source
    required: true
    help: File to upload

  flags:
  - long: --user
    short: -u
    arg: user
    help: Username to use for logging in
    required: true
  - long: --password
    short: -p
    arg: password
    help: Password to use for logging in
```

## `src/help_command.sh`

```bash
command="${args[command]}"
long_usage=yes

if [[ -z "$command" ]]; then
  # No command argument, show the global help
  help_function=cli_usage
else
  # Show the help for the requested command
  help_function="cli_${command}_usage"
fi

# Call the help function if it exists
if [[ $(type -t "$help_function") ]]; then
  "$help_function"
else
  echo "No help available for this command"
  exit 1
fi


```


## Generated script output

### `$ ./cli`

```shell
cli - Sample application

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  help       Show help about a command
  download   Download a file
  upload     Upload a file



```

### `$ ./cli -h`

```shell
cli - Sample application

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  help       Show help about a command
  download   Download a file
  upload     Upload a file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  API_KEY
    Set your API key



```

### `$ ./cli help`

```shell
cli - Sample application

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  help       Show help about a command
  download   Download a file
  upload     Upload a file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  API_KEY
    Set your API key



```

### `$ ./cli help download`

```shell
cli download - Download a file

Alias: d

Usage:
  cli download SOURCE [TARGET] [OPTIONS]
  cli download --help | -h

Options:
  --help, -h
    Show this help

  --force, -f
    Overwrite existing files

Arguments:
  SOURCE
    URL to download from

  TARGET
    Target filename (default: same as source)

Environment Variables:
  DEFAULT_TARGET_LOCATION
    Set the default location to download to

Examples:
  cli download example.com
  cli download example.com ./output -f



```

### `$ ./cli help no_such_command`

```shell
No help available for this command


```



