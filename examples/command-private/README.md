# Private Command Example

Demonstrates how to hide a command from the commands list.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

<!-- include: src/connect_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application with private commands
version: 0.1.0

commands:
- name: connect
  alias: c
  help: Connect to the metaverse

  args:
  - name: protocol
    required: true
    allowed: [ftp, ssh]
    help: Protocol to use for connection

# These two commands will be hidden from the commands list, but still executable
# and visible when running 'cli connect-ftp --help' or 'cli connect-ssh --help'
- name: connect-ftp
  help: Connect via FTP
  private: true

- name: connect-ssh
  help: Connect via SSH
  private: true
```

## `src/connect_command.sh`

```bash
# Execute a subsequent (private) command based on the PROTOCOL argument
protocol=${args[protocol]}
cmd="./cli connect-$protocol"
echo "=== Calling $cmd"
$cmd
```


## Generated script output

### `$ ./cli`

```shell
cli - Sample application with private commands

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  connect   Connect to the metaverse



```

### `$ ./cli -h`

```shell
cli - Sample application with private commands

Usage:
  cli COMMAND
  cli [COMMAND] --help | -h
  cli --version | -v

Commands:
  connect   Connect to the metaverse

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number



```

### `$ ./cli connect ftp`

```shell
=== Calling ./cli connect-ftp
# this file is located in 'src/connect_ftp_command.sh'
# code for 'cli connect-ftp' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./cli connect-ssh`

```shell
# this file is located in 'src/connect_ssh_command.sh'
# code for 'cli connect-ssh' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none


```

### `$ ./cli connect-ftp --help`

```shell
cli connect-ftp - Connect via FTP

Usage:
  cli connect-ftp
  cli connect-ftp --help | -h

Options:
  --help, -h
    Show this help



```



