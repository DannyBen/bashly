# Git Example

Demonstrates how to configure sub-commands, similar to what `git` does
(`git status`, `git commit`, etc.).

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

````yaml
name: git
help: Git example
version: 0.1.0

commands:
- name: status
  alias: s*
  help: Show repository status

- name: commit
  alias: c*
  help: Commit changes

  flags:
  - long: --message
    short: -m
    arg: MESSAGE
    help: Commit message

  - long: --all
    short: -a
    help: Automatically stage files
````



## Output

### `$ ./git`

````shell
git - Git example

Usage:
  git COMMAND
  git [COMMAND] --help | -h
  git --version | -v

Commands:
  status   Show repository status
  commit   Commit changes



````

### `$ ./git -h`

````shell
git - Git example

Usage:
  git COMMAND
  git [COMMAND] --help | -h
  git --version | -v

Commands:
  status   Show repository status
  commit   Commit changes

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



````

### `$ ./git s`

````shell
# This file is located at 'src/status_command.sh'.
# It contains the implementation for the 'git status' command.
# The code you write here will be wrapped by a function named 'git_status_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args: none


````

### `$ ./git status -h`

````shell
git status - Show repository status

Alias: s*

Usage:
  git status
  git status --help | -h

Options:
  --help, -h
    Show this help



````

### `$ ./git commit -h`

````shell
git commit - Commit changes

Alias: c*

Usage:
  git commit [OPTIONS]
  git commit --help | -h

Options:
  --message, -m MESSAGE
    Commit message

  --all, -a
    Automatically stage files

  --help, -h
    Show this help



````

### `$ ./git commit -a -m "initial commit"`

````shell
# This file is located at 'src/commit_command.sh'.
# It contains the implementation for the 'git commit' command.
# The code you write here will be wrapped by a function named 'git_commit_command()'.
# Feel free to edit this file; your changes will persist when regenerating.
args:
- ${args[--all]} = 1
- ${args[--message]} = initial commit


````



