# Render Mandoc Example

This example shows how to render man pages from your bashly commands, and how
to use custom properties to add more information to the man page.

This example was generated with:

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
$ bashly render :mandoc docs
```

-----

## `bashly.yml`

````yaml
name: download
help: Sample application
version: 0.1.0

# Optional, custom properties that are used by the mandoc renderer
# Run `bashly render :mandoc --about` for more info.
x_mandoc_authors: Lana Lang
x_mandoc_footer: |-
  # ISSUE TRACKER
  Report issues at <https://github.com/lanalang/smallville>
x_mandoc_see_also:
  - docker
  - docker-compose.yml(5)

dependencies:
  aws-cli: Download from <https://aws.amazon.com/cli/>

args:
- name: source
  required: true
  allowed: [server1, server2]
  help: Source to download from
- name: target
  help: "Target filename (default: same as source)"
  repeatable: true

flags:
- long: --force
  short: -f
  help: Overwrite existing files
- long: --debug
  short: -d
  help: Show debug information
````



## Output

### `$ man docs/download.1 | col -bx`

````shell
download(1)                   Sample application                   download(1)

NAME
       download - Sample application

SYNOPSIS
       download SOURCE [TARGET...]  OPTIONS

DESCRIPTION
       Sample application

ARGUMENTS
   SOURCE
       Source to download from

       • Required

       • Allowed Values: server1, server2

   TARGET
       Target filename (default: same as source)

       • Repeatable

OPTIONS
   --force, -f
       Overwrite existing files

   --debug, -d
       Show debug information

DEPENDENCIES
   aws-cli
       Download from <https://aws.amazon.com/cli/>

SEE ALSO
       docker(1), docker-compose.yml(5)

ISSUE TRACKER
       Report issues at <https://github.com/lanalang/smallville>

AUTHORS
       Lana Lang.

Version 0.1.0                     August 2024                      download(1)


````



