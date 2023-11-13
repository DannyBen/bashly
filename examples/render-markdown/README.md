# Render Markdown Example

This example shows how to render markdown documentation from your bashly
commands, and how to use custom properties to add more information to
the markdown output.

This example was generated with:

<!-- include: docs/index.md -->

```bash
$ bashly init --minimal
# ... now edit src/bashly.yml to match the example ...
$ bashly render :markdown docs
```

-----

## `bashly.yml`

````yaml
name: download
help: Sample application
version: 0.1.0

# Optional, custom properties that are used by the markdown renderer
# Run `bashly render :markdown --about` for more info.
x_markdown_footer: |-
  # ISSUE TRACKER
  Report issues at <https://github.com/lanalang/smallville>

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

## `docs/index.md`

````markdown
# download

Sample application

| Attributes       | &nbsp;
|------------------|-------------
| Version:         | 0.1.0

## Usage

```bash
download SOURCE [TARGET...] [OPTIONS]
```

## Dependencies

#### *aws-cli*

Download from \<https://aws.amazon.com/cli/\>

## Arguments

#### *SOURCE*

Source to download from

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | server1, server2

#### *TARGET*

Target filename (default: same as source)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

## Options

#### *--force, -f*

Overwrite existing files

#### *--debug, -d*

Show debug information

# ISSUE TRACKER
Report issues at \<https://github.com/lanalang/smallville\>

````


## Output

*None*

