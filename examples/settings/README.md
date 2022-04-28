# Settings Example

Demonstrates how to use the bashly `settings.yml` file to configure some 
aspects of the script generation commands.

This example was generated with:

```bash
$ bashly add settings
# ... now edit settings.yml file to match the example ...
$ bashly init
$ bashly generate
```

<!-- include: settings.yml -->

-----



## `settings.yml`

```yaml
source_dir: source
target_dir: out

```


## Generated script output

### `$ ./out/cli`

```shell
cli - Sample application

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  download   Download a file
  upload     Upload a file



```



