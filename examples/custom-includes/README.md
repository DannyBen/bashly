# Custom Includes Example

This example was generated with:

    $ bashly init
    $ bashly add lib
    $ bashly generate
    
Running the `bashly add lib` command, simply craetes a sample file in the [src/lib](src/lib) folder, which can then be edited to include your custom function(s).

In order to keep your scripts clean and maintainable, it is recommended that you place each of your custom functions in their own file inside the `lib` folder.

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



