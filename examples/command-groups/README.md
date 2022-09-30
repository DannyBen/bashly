# Command Groups Example

Demonstrates how to visually group commands under their own caption. This is
useful for scripts that contain many commands that provide different sets of
functionality.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: ftp
help: Sample application with command grouping
version: 0.1.0

commands:
- name: download
  help: Download a file

  # By specifying a group, the `download` comnmand will be printed under
  # this `File` caption.
  group: File

  args:
  - name: file
    required: true
    help: File to download

- name: upload
  help: Upload a file
  group: File

  args:
  - name: file
    required: true
    help: File to upload

- name: login
  help: Write login credentials to the config file

  # The `login` command will be printed under the `Login` caption.
  group: Login

- name: logout
  help: Delete login credentials to the config file
  group: Login
```



## Generated script output

### `$ ./ftp`

```shell
ftp - Sample application with command grouping

Usage:
  ftp COMMAND
  ftp [COMMAND] --help | -h
  ftp --version | -v

File Commands:
  download   Download a file
  upload     Upload a file

Login Commands:
  login      Write login credentials to the config file
  logout     Delete login credentials to the config file



```

### `$ ./ftp -h`

```shell
ftp - Sample application with command grouping

Usage:
  ftp COMMAND
  ftp [COMMAND] --help | -h
  ftp --version | -v

File Commands:
  download   Download a file
  upload     Upload a file

Login Commands:
  login      Write login credentials to the config file
  logout     Delete login credentials to the config file

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



```

### `$ ./ftp login`

```shell
# this file is located in 'src/login_command.sh'
# code for 'ftp login' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```



