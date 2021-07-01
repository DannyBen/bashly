Custom Includes Example
==================================================

This example was generated with:

    $ bashly init
    $ bashly add lib
    $ bashly generate

-----

## `bashly.yml`

```yaml
name: download
help: Sample minimal application with custom strings
version: 0.1.0

args:
- name: source
  help: URL to download from
```

## Generated script output

```shell
$ ./download

Before custom code
---
This is a place to write custom code that is needed by more than
one part of the application.
Under most circumstances, you will not need it, but it is provided
for extra flexibility.
---
After custom code


```



