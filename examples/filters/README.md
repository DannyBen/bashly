# Filters Example

Demonstrates the use of filters that run before a command, and possibly halt
its execution.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/lib/filter_docker_running.sh to match the example ...
# ... now edit src/lib/filter_redis_running.sh to match the example ...
$ bashly generate
```

<!-- include: src/lib/filter_docker_running.sh src/lib/filter_redis_running.sh -->

---

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application
version: 0.1.0

commands:
- name: container
  help: Perform actions on a docker container

  # The filters option can be a string or an array of strings.
  # When the command is executed, your script will look for a function named
  # "filter_docker_running" and execute it. If it prints a string, it will be
  # considered an error and the command execution will be halted.
  filters: docker_running

  args:
  - name: id
    required: true
    help: Container ID

- name: redis
  help: Perform actions in redis
  filters: [docker_running, redis_running]
```

## `src/lib/filter_docker_running.sh`

```bash
# Print an error string if docker is not running.
# The script will automatically exit if this function prints anything.
filter_docker_running() {
  docker info > /dev/null 2>&1 || echo "Docker must be running"
}

```

## `src/lib/filter_redis_running.sh`

```bash
# This is just a sample filter designed to always fail
filter_redis_running() {
  echo "Redis must be running (fake)"
}

```


## Generated script output

### `$ ./cli container sample-id`

```shell
# this file is located in 'src/container_command.sh'
# code for 'cli container' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args:
- ${args[id]} = sample-id


```

### `$ ./cli redis`

```shell
Redis must be running (fake)


```



