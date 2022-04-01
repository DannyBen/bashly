# Repeatable Argument Example

Demonstrates the use of repeatable arguments that allow users to run commands
such `convert *.png` or `convert 1.png 2.png 3.png`.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/root_command.sh to match the example ...
$ bashly generate
```

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: upcase
help: Sample application to demonstrate the use of repeatable arguments
version: 0.1.0

args:
- name: file
  help: One or more files to process
  required: true

  # Setting repeatable to true means that the user can provide multiple arguments
  # for it.
  # The argument will be received as a quoted and space-delimited string which
  # needs to be converted to an array with `eval "data=(${args[file]})"`
  repeatable: true

examples:
- upcase README.md LICENSE
- upcase *.md
```

## `src/root_command.sh`

```bash
# Convert the space delimited string to an array
files=''
eval "files=(${args[file]})"

echo
echo "files:"
for i in "${files[@]}"; do
  echo "  path: $i:"
  content="$(cat "$i")"
  echo "  content: ${content}"
  echo "  upcase: ${content^^}"
done

echo
inspect_args

```


## Generated script output

### `$ ./upcase -h`

```shell
upcase - Sample application to demonstrate the use of repeatable arguments

Usage:
  upcase FILE...
  upcase --help | -h
  upcase --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  FILE...
    One or more files to process

Examples:
  upcase README.md LICENSE
  upcase *.md



```

### `$ ./upcase file1`

```shell

files:
  path: file1:
  content: content of file1
  upcase: CONTENT OF FILE1

args:
- ${args[file]} = "file1"


```

### `$ ./upcase file*`

```shell

files:
  path: file1:
  content: content of file1
  upcase: CONTENT OF FILE1
  path: file2:
  content: content of file2
  upcase: CONTENT OF FILE2

args:
- ${args[file]} = "file1" "file2"


```



