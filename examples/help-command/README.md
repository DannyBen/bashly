# Help Command Example

Demonstrates how to add a `help` command to your script. This is only needed
if you prefer to have the `your-cli help COMMAND` syntax in addition to the 
natively supported `your-cli COMMAND --help` syntax.

This functionality is achieved by adding a custom validation filter that
verifies the requested help function is callable.

This example was generated with:

```bash
$ bashly init
$ bashly add lib
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/lib/validate_help_exists.sh to match the example ...
$ bashly generate
# ... now edit src/help_command.sh to match the example ...
$ bashly generate

```

<!-- include: src/lib/validate_help_exists.sh src/help_command.sh -->

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
  
  # The command argument will be validated with our custom validation
  # `help_exists`, which is placed in `src/lib/validate_help_exists.sh`
  - name: command
    validate: help_exists
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

## `src/lib/validate_help_exists.sh`

```bash
# This function will be called automatically with the argument under validation
# as provided by the user.
# It will then check that the internal bashly function responsible for showing
# help exists, and echo an error if it does not.
validate_help_exists() {
  command="$1"
  
  if [[ -z "$command" ]]; then
    # The user called `cli help` - so the help function is the root cli_usage
    # function (replace 'cli' with the name of your script).
    function_name="cli_usage"
  
  else
    # The user called `cli help COMMAND` - so we check that the command is valid
    # by ensuring we have a help function for it.
    function_name="cli_${command}_usage"
  fi
  
  [[ $(type -t "$function_name") ]] || echo "no help for this command"
}
```

## `src/help_command.sh`

```bash
command="${args[command]}"
long_usage=yes

# If we have reached this point, we know that the help subject is valid, so 
# just call the relevant help function.
if [[ -z "$command" ]]; then
  cli_usage
else
  "cli_${command}_usage"
fi

```


## Generated script output

### `$ ./cli`

```shell
cli - Sample application

Usage:
  cli [command]
  cli [command] --help | -h
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
  cli [command]
  cli [command] --help | -h
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
  cli [command]
  cli [command] --help | -h
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
  cli download SOURCE [TARGET] [options]
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
validation error in COMMAND:
no help for this command


```



