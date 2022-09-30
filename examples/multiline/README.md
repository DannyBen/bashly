# Multiline Example

Demonstrates how to write more detailed help messages.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: multi
help: |-
  Multiline test
  
  This is a multiline test example. Long lines are going to be properly wrapped at the 80 character mark.

version: 0.1.0

commands:
- name: multiline
  
  # Using the YAML multiline marker allows you to define help messages with 
  # multiple lines
  help: |-
    Do some multiline work.

    This is a long process and takes time, therefore it takes a lot of lines to describe and this line is particularly long.

    But - not all hope is lost. Bashly should respect newlines and word-wrap long lines properly at the 80 character mark.

  args:
  - name: my_arg
    help: |-
      Argument with multiline.

      Once again we gather here to prepare some long lines that will most likely seem silly to anyone who reads them.

      But, it is just needed for testing - otherwise, it will not only be silly, but it will also be buggy!

  flags:
  - long: --long
    help: |-
      Long flag with long text.

      Finally, this will be the last multiline string we type (hopefully), but once we are done with this, we will be done with all.

- name: regular
  help: Standard help line

  args:
  - name: repo
    help: Repository name

examples:
  - |-
    Examples can also use multiple lines. This can be useful if we need to explain the example, for instance like we are doing here:

      multi multiline --flag

environment_variables:
- name: multi_vitamin
  help: |-
    Environment variables can also use multiple lines. This can be useful if we need to explain - in excruciating detail - what the environemnt variable is used for.
```



## Generated script output

### `$ ./multi`

```shell
multi - Multiline test

Usage:
  multi COMMAND
  multi [COMMAND] --help | -h
  multi --version | -v

Commands:
  multiline   Do some multiline work.
  regular     Standard help line



```

### `$ ./multi -h`

```shell
multi

  Multiline test
  
  This is a multiline test example. Long lines are going to be properly wrapped
  at the 80 character mark.

Usage:
  multi COMMAND
  multi [COMMAND] --help | -h
  multi --version | -v

Commands:
  multiline   Do some multiline work.
  regular     Standard help line

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  MULTI_VITAMIN
    Environment variables can also use multiple lines. This can be useful if we
    need to explain - in excruciating detail - what the environemnt variable is
    used for.

Examples:
  Examples can also use multiple lines. This can be useful if we need to explain
  the example, for instance like we are doing here:
  
    multi multiline --flag



```

### `$ ./multi multiline`

```shell
# this file is located in 'src/multiline_command.sh'
# code for 'multi multiline' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./multi multiline -h`

```shell
multi multiline

  Do some multiline work.
  
  This is a long process and takes time, therefore it takes a lot of lines to
  describe and this line is particularly long.
  
  But - not all hope is lost. Bashly should respect newlines and word-wrap long
  lines properly at the 80 character mark.

Usage:
  multi multiline [MY_ARG] [OPTIONS]
  multi multiline --help | -h

Options:
  --help, -h
    Show this help

  --long
    Long flag with long text.
    
    Finally, this will be the last multiline string we type (hopefully), but
    once we are done with this, we will be done with all.

Arguments:
  MY_ARG
    Argument with multiline.
    
    Once again we gather here to prepare some long lines that will most likely
    seem silly to anyone who reads them.
    
    But, it is just needed for testing - otherwise, it will not only be silly,
    but it will also be buggy!



```



