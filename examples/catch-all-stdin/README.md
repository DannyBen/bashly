# Catch All with stdin input

Demonstrates how to process multiple files as arguments, or from stdin.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/root_command.yml to match the example ...
$ bashly generate
```

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

catch_all:
  label: file
  help: Path to one or more files. Reads from stdin if empty or "-".

flags:
- long: --format
  short: -f
  arg: format
  help: Specify file format
  default: json
  allowed: [csv, json]

examples:
- cli file1 file2 --format csv
- cli --format csv file1 file2
- cat file1 | cli --format csv
- cat file* | cli - --format csv
```

## `src/root_command.sh`

```bash
inspect_args

# Read contents of the provided file(s)
content=""
for file in "${other_args[@]}"; do
  content+="$(cat "$file")"
  content+=$'\n'
done

# Read stdin if file(s) not provided as arguments
if [[ -z "$content" ]]; then
  content="$(cat -)"
fi

echo
echo "collected file contents:"
echo "$content"
echo

```


## Generated script output

### `$ ./cli -h`

```shell
cli - Sample application

Usage:
  cli [OPTIONS] [FILE...]
  cli --help | -h
  cli --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --format, -f FORMAT
    Specify file format
    Allowed: csv, json
    Default: json

Arguments:
  FILE...
    Path to one or more files. Reads from stdin if empty or "-".

Examples:
  cli file1 file2 --format csv
  cli --format csv file1 file2
  cat file1 | cli --format csv
  cat file* | cli - --format csv



```

### `$ ./cli file1 file2 --format csv`

```shell
args:
- ${args[--format]} = csv

other_args:
- ${other_args[*]} = file1 file2
- ${other_args[0]} = file1
- ${other_args[1]} = file2

collected file contents:
file1 content
file2 content




```

### `$ ./cli -f=csv file1 file2`

```shell
args:
- ${args[--format]} = csv

other_args:
- ${other_args[*]} = file1 file2
- ${other_args[0]} = file1
- ${other_args[1]} = file2

collected file contents:
file1 content
file2 content




```

### `$ cat file1 | ./cli --format csv`

```shell
args:
- ${args[--format]} = csv

collected file contents:
file1 content



```

### `$ cat file* | ./cli -`

```shell
args:
- ${args[--format]} = json

other_args:
- ${other_args[*]} = -
- ${other_args[0]} = -

collected file contents:
file1 content
file2 content




```



