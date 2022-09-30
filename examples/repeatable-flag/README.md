# Repeatable Flag Example

Demonstrates the use of repeatable flags that allow users to run commands such
as `download -d one -d "two three" -vvv`.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/root_command.sh to match the example ...
$ bashly generate
```

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: download
help: Sample application to demonstrate the use of repeatable flags
version: 0.1.0

flags:
- long: --data
  short: -d
  arg: data
  help: Provide data values
  required: true

  # Setting this to true on a flag with an argument means the user can type it
  # multiple times, like --data a --data b.
  # The argument will be received as a quoted and space-delimited string which
  # needs to be converted to an array with `eval "data=(${args[--data]})"`
  repeatable: true

- long: --verbose
  short: -v
  help: Set verbosity level

  # Setting this to true on a regular flag means the user can type it multiple
  # times, in the form of -vvv or -v -v -v.
  # The argument's value will hold the number of times it was entered.
  repeatable: true

examples:
- download -d one -d "two three" -vvv
```

## `src/root_command.sh`

```bash
# Convert the space delimited string to an array
eval "data=(${args[--data]})"

echo "Data elements:"
for i in "${data[@]}"; do
  echo "$i"
done

# The --verbose arg will contain the number of times it was used by the user
verbose=${args[--verbose]}
echo ""
echo "Verbosity level: $verbose"
echo ""

inspect_args

```


## Generated script output

### `$ ./download -h`

```shell
download - Sample application to demonstrate the use of repeatable flags

Usage:
  download [OPTIONS]
  download --help | -h
  download --version

Options:
  --help, -h
    Show this help

  --version
    Show version number

  --data, -d DATA (required) (repeatable)
    Provide data values

  --verbose, -v (repeatable)
    Set verbosity level

Examples:
  download -d one -d "two three" -vvv



```

### `$ ./download -d one -d "two three" -vvv`

```shell
Data elements:
one
two three

Verbosity level: 3

args:
- ${args[--data]} = "one" "two three"
- ${args[--verbose]} = 3


```



