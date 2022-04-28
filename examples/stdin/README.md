# STDIN Example

Demonstrates how to read from STDIN.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit bashly.yml to match ...
$ bashly generate
# ... now edit *.sh to match ...
$ bashly generate
```

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: STDIN Example
version: 0.1.0

args:
- name: path
  
  # Set the default path value to -, which is the standard operator for stdin.
  default: "-"
  help: Path to file (reads from stdin if empty)

flags:
- long: --file
  short: -f
  arg: path

  # This is also supported in flags
  # Note that in both cases, your script needs to handle the value '-' as there
  # is no special treatment in bashly, other than allowing '-' as argument.
  default: "-"
  help: Another path to file
```

## `src/root_command.sh`

```bash
inspect_args

# Since cat knows how to handle '-' as a value, it will work with both a file
# path and '-' argument.
cat "${args[path]}"

```


## Generated script output

### `$ ./cli some-file`

```shell
args:
- ${args[--file]} = -
- ${args[path]} = some-file
some file with some content


```

### `$ cat some-file | ./cli`

```shell
args:
- ${args[--file]} = -
- ${args[path]} = -
some file with some content


```

### `$ cat some-file | ./cli -`

```shell
args:
- ${args[--file]} = -
- ${args[path]} = -
some file with some content


```



