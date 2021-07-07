# Extensible Command Example

Demonstrates how to allow your script's users to add more commands to your script (in any language), without requiring them to edit your script.

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application that can be externally extended
version: 0.1.0

# Setting `extensible` to `true` will cause the execution of `cli anything` to
# look for an executable script named `cli-anything` in the PATH, and invoke it
# if it is found.
extensible: true

commands:
- name: upload
  short: u
  help: Upload a file
  args:
  - name: source
    required: true
    help: File to upload

- name: download
  short: d
  help: Download a file

  args:
  - name: source
    required: true
    help: File to download
```

## Generated script output

### `$ ./cli`

```shell
cli - Sample application that can be externally extended

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  upload     Upload a file
  download   Download a file



```

### `$ ./cli status --some --flags`

```shell
This is an external executable that serves as an extension to
the cli app.
If placed in the path, it will be executed whenever someone runs:
$ cli status <any argument>

Received args: --some --flags


```



