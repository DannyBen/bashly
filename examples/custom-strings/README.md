# Custom Strings Example

This example was generated with:

    $ bashly init
    $ bashly add strings
    $ bashly generate

Running the `bashly add strings` command, simply generates  the strings configuration file in [src/bashly-strings.yml](src/bashly-strings.yml). You may edit this file and regenerate your script in order to replace the format of any (or all) help messages and error messages.

Note that you may delete any of the generated string values completely if you do not wish to change them.

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

## Generated script output

```shell
$ ./download

Boom! a required argument is missing: SOURCE
usage: download SOURCE [options]


$ ./download -h

download - Sample minimal application with custom strings

== Usage ==

  download SOURCE [options]
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



$ ./download somesource

Yo! you forgot a flag: --out, -o DIR


$ ./download somesource -o

Hey! the flag --out requires an argument: --out, -o DIR


```



