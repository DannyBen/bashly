# Footer Example

Demonstrates how to add a footer text to the `--help` message.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: download
help: Sample application with a help footer
version: 0.1.0
footer: |
  This will appear at the end of the --help message.

  It can contain multiple lines, and "double" or 'single' quotes are
  properly escaped.

args:
- name: source
  help: URL to download from
```



## Generated script output

### `$ ./download`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./download -h`

```shell
download - Sample application with a help footer

Usage:
  download [SOURCE]
  download --help | -h
  download --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Arguments:
  SOURCE
    URL to download from

This will appear at the end of the --help message.

It can contain multiple lines, and "double" or 'single' quotes are
properly escaped.




```



