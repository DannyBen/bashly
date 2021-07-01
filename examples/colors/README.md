Colors Example
==================================================

This example was generated with:

    $ bashly init
    $ bashly add colors
    $ bashly generate

The `bashly add colors` command, simply created the [src/lib/colors.sh](src/lib/colors.sh) file, with useful color functions that will be automatically included in the generated script.



See the manually edited [src/root_command.sh](src/root_command.sh) for usage examples.

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

## Generated script output

```shell
$ ./colorly

[4mMessage Recevied:[0m

  => [1;32mhello colors[0m
  ==> [1;31mhello colors[0m
  ===> [1;34mhello colors[0m



```



