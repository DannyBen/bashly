# Custom Script Header Example

This example shows how to replace the script header by simply placing a 
file called `header.sh` in your `src` folder.

Under most circumstances, you should not do it, and instead put your
initialization code in `src/initialize.sh`.

This example was generated with:

```bash
$ bashly init --minimal
$ bashly generate
```

<!-- include: src/header.sh -->

-----

## `bashly.yml`

```yaml
name: download
help: Sample minimal application without commands
version: 0.1.0

args:
- name: source
  required: true
  help: URL to download from
- name: target
  help: "Target filename (default: same as source)"

flags:
- long: --force
  short: -f
  help: Overwrite existing files

examples:
- download example.com
- download example.com ./output -f
```

## `src/header.sh`

```bash
#!/usr/bin/env bash

# This is a custom header that will be injected to the very top of the 
# script, replacing the original header.
# Note that in most cases you should use initialize.sh instead.

some_condition=true

if [ "$some_condition" = true ]; then
  echo "Some condition was met, aborting"
  exit
fi


```


## Generated script output

### `$ ./download`

```shell
Some condition was met, aborting


```



