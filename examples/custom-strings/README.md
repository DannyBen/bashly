# Custom Strings Example

Demonstrates how to customize bashly's error strings and usage string templates.

This example was generated with:

```bash
$ bashly init --minimal
$ bashly add strings
$ bashly generate
```

Running the `bashly add strings` command, simply generates  the strings
configuration file in [src/bashly-strings.yml](src/bashly-strings.yml). You may
edit this file and regenerate your script in order to replace the format of
any (or all) help messages and error messages.

Note that you may delete any of the generated string values completely if you do
not wish to change them.

<!-- include: src/bashly-strings.yml -->

-----

## `bashly.yml`

```yaml
name: download
help: Sample minimal application with custom strings
version: 0.1.0

args:
- name: source
  required: true
  help: URL to download from

flags:
- long: --out
  short: -o
  arg: dir
  required: true
  help: Target directory
```

## `src/bashly-strings.yml`

```yaml
# Usage captions
usage: "== Usage ==\\n"
options: "== Options ==\\n"
arguments: "== Arguments ==\\n"
commands: "== Commands ==\\n"

# Fixed flags help text
help_flag_text: Show this helpful help
version_flag_text: Show version number

# Error messages
flag_requires_an_argument: "Hey! the flag %{name} requires an argument: %{usage}"
missing_required_argument: "Boom! a required argument is missing: %{arg}\\nusage: %{usage}"
missing_required_flag: "Yo! you forgot a flag: %{usage}"


```


## Generated script output

### `$ ./download`

```shell
Boom! a required argument is missing: SOURCE
usage: download SOURCE [OPTIONS]


```

### `$ ./download -h`

```shell
download - Sample minimal application with custom strings

== Usage ==

  download SOURCE [OPTIONS]
  download --help | -h
  download --version | -v

== Options ==

  --help, -h
    Show this helpful help

  --version, -v
    Show version number

  --out, -o DIR (required)
    Target directory

== Arguments ==

  SOURCE
    URL to download from



```

### `$ ./download somesource`

```shell
Yo! you forgot a flag: --out, -o DIR


```

### `$ ./download somesource -o`

```shell
Hey! the flag --out requires an argument: --out, -o DIR


```



