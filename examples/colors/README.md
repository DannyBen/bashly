# Colors Example

This example demonstrates how to add color print functions.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add colors
$ bashly generate
# ... now edit src/root_command.sh ...
$ bashly generate
```

The `bashly add colors` command, simply created the [src/lib/colors.sh]
(src/lib/colors.sh) file, with useful color functions that will be
automatically included in the generated script.

See the manually edited [src/root_command.sh](src/root_command.sh) for usage
examples.

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: colorly
help: Sample application that uses the color functions
version: 0.1.0

args:
- name: message
  help: "Message to show [default: hello colors]"
```

## `src/root_command.sh`

```bash
message=${args[message]:-hello colors}

underlined "Message Recevied":
echo
echo "  => $(green_bold "$message")"
echo "  ==> $(red_bold "$message")"
echo "  ===> $(blue_bold "$message")"
echo

```


## Generated script output

### `$ ./colorly`

```shell
[4mMessage Recevied:[0m

  => [1;32mhello colors[0m
  ==> [1;31mhello colors[0m
  ===> [1;34mhello colors[0m



```

### `$ NO_COLOR=1 ./colorly`

```shell
Message Recevied:

  => hello colors
  ==> hello colors
  ===> hello colors



```



