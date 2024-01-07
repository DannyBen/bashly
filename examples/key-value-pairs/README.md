# Key Value Pairs Example

Demonstrates how to implement support for a command line that accepts
`key=value` pairs, either as positional arguments of repeatable flags.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now create and edit src/lib/extract_params.sh to match the example ...
$ bashly generate
# ... now edit src/root_command.sh ...
$ bashly generate
```

See the [src/root_command.sh](src/root_command.sh) for usage example.


<!-- include: src/root_command.sh src/lib/extract_params.sh -->

-----

## `bashly.yml`

````yaml
name: cli
help: Sample application to demonstrate `key=value` arguments and flags
version: 0.1.0

args:
- name: param
  required: true
  repeatable: true
  unique: true
  help: key=value parameters

flags:
- long: --option
  short: -o
  arg: option
  repeatable: true
  unique: true
  help: key=value parameters

examples:
  - cli user=bob email=bob@spunge.com --option page=2 --option count=20
````

## `src/root_command.sh`

````bash
extract_params "${args[param]}"

echo "Positional Arguments:"
for key in "${!params[@]}"; do
  echo "$key => ${params[$key]}"
done

extract_params "${args[--option]}"

echo
echo "Options (--option):"
for key in "${!params[@]}"; do
  echo "$key => ${params[$key]}"
done

````

## `src/lib/extract_params.sh`

````bash
## Convert an array of key=value pairs to an associative array.
## Calling this function will populate an associative array named `params`.
function extract_params {
  declare -gA params=()
  declare -a list=()
  local pattern="([^=]+)=(.+)"
  eval "list=($*)"
  
  for pair in "${list[@]}"; do
    if [[ $pair =~ $pattern ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      params["$key"]="$value"
    fi
  done
}
````


## Output

### `$ ./cli -h`

````shell
cli - Sample application to demonstrate `key=value` arguments and flags

Usage:
  cli PARAM... [OPTIONS]
  cli --help | -h
  cli --version | -v

Options:
  --option, -o OPTION (repeatable)
    key=value parameters

  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  PARAM...
    key=value parameters

Examples:
  cli user=bob email=bob@spunge.com --option page=2 --option count=20



````

### `$ ./cli user=bob email=bob@spunge.com --option page=2 --option count=20`

````shell
Positional Arguments:
email => bob@spunge.com
user => bob

Options (--option):
count => 20
page => 2


````



