# Before/After Hooks Example

This example demonstrates how to run common code before or after executing any
command.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add hooks
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: hooks
help: Sample application that uses before/after hooks
version: 0.1.0

flags:
- long: --debug
  short: -d
  help: Enable debug mode
```



## Generated script output

### `$ ./hooks`

```shell
==[ Before Hook Called ]==
args: none
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args: none
==[ After Hook Called ]==


```

### `$ ./hooks --debug`

```shell
==[ Before Hook Called ]==
args:
- ${args[--debug]} = 1
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[--debug]} = 1
==[ After Hook Called ]==


```



