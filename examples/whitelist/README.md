# Whitelist Arguments and Flag Arguments

Demonstrates how to specify a predetermined list of allowed values for arguments
and flag arguments.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly generate
```

-----

## `bashly.yml`

```yaml
name: login
help: Sample showing the use of arg and flag whitelist (allowed values)
version: 0.1.0

args:
- name: region
  help: Region to connect to
  # Whitelist + required
  allowed: [eu, us]
  required: true

- name: environment
  help: Environment to connect to
  # Whitelist + default
  allowed: [stage, production, development]
  default: development

flags:
- long: --user
  short: -u
  arg: name
  help: User name
  # Whitelist + required
  allowed: [user, admin]
  required: true

- long: --protocol
  short: -p
  arg: type
  help: Protocol to connect with
  # Whitelist + default
  allowed: [ftp, ssh, http]
  default: ssh
```



## Generated script output

### `$ ./login`

```shell
missing required argument: REGION
usage: login REGION [ENVIRONMENT] [OPTIONS]


```

### `$ ./login -h`

```shell
login - Sample showing the use of arg and flag whitelist (allowed values)

Usage:
  login REGION [ENVIRONMENT] [OPTIONS]
  login --help | -h
  login --version | -v

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

  --user, -u NAME (required)
    User name
    Allowed: user, admin

  --protocol, -p TYPE
    Protocol to connect with
    Allowed: ftp, ssh, http
    Default: ssh

Arguments:
  REGION
    Region to connect to
    Allowed: eu, us

  ENVIRONMENT
    Environment to connect to
    Allowed: stage, production, development
    Default: development



```

### `$ ./login america`

```shell
missing required flag: --user, -u NAME


```

### `$ ./login america --user admin`

```shell
region must be one of: eu, us


```

### `$ ./login eu --user hacker`

```shell
--user must be one of: user, admin


```

### `$ ./login eu --user admin`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[environment]} = development
- ${args[--protocol]} = ssh
- ${args[region]} = eu
- ${args[--user]} = admin


```

### `$ ./login us --user user --protocol icmp`

```shell
--protocol must be one of: ftp, ssh, http


```

### `$ ./login eu production --user admin --protocol ssh`

```shell
# this file is located in 'src/root_command.sh'
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[environment]} = production
- ${args[--protocol]} = ssh
- ${args[region]} = eu
- ${args[--user]} = admin


```



