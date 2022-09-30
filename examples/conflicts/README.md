# Conflicting Flags Example

Demonstrates the use of conflicting flags that cannot be executed together.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: download
help: Sample application to demonstrate the use of conflicting flags
version: 0.1.0

flags:
- long: --cache
  help: Enable cache
  # Running --cache with --no-cache is not permitted
  conflicts: [--no-cache]
- long: --no-cache
  help: Diisable cache
  # Running --no-cache with --cache or with --fast is not permitted
  conflicts: [--cache, --fast]
- long: --fast
  help: Run faster
  # Make sure to add the conflicting flags in both flags
  conflicts: [--no-cache]
```



## Generated script output

### `$ ./download -h`

```shell
download - Sample application to demonstrate the use of conflicting flags

Usage:
  download [OPTIONS]
  download --help | -h
  download --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --cache
    Enable cache

  --no-cache
    Diisable cache

  --fast
    Run faster



```

### `$ ./download --cache`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--cache]} = 1


```

### `$ ./download --no-cache --fast`

```shell
conflicting options: --fast cannot be used with --no-cache


```



