# Custom Includes Example

Demonstrates how to organize your code in additional functions.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
$ bashly add lib
$ bashly generate
# ... now edit src/root_command.sh ...
$ bashly generate
```

Running the `bashly add lib` command, simply creates a sample file in the
[src/lib](src/lib) folder, which can then be edited to include your custom
function(s).

In order to keep your scripts clean and maintainable, it is recommended that you
place each of your custom functions in their own file inside the `lib` folder.

<!-- include: src/root_command.sh src/lib/sample_function.sh -->

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

## `src/root_command.sh`

```bash
# Call our custom library function
echo "Before custom code"
sample_function
echo "After custom code"

```

## `src/lib/sample_function.sh`

```bash
# Add any function here that is needed in more than one parts of your
# application, or that you otherwise wish to extract from the main function
# scripts.
#
# Note that code here should be wrapped inside bash functions, and it is
# recommended to have a separate file for each function.
#
# Subdirectories will also be scanned for *.sh, so you have no reason not
# to organize your code neatly.
#
sample_function() {
  echo "it works"
}

```


## Generated script output

### `$ ./download`

```shell
Before custom code
it works
After custom code


```



