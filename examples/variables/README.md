# Variables Example

Demonstrates how to define varaibles from the bashly.yml configuration.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/download_command.sh to match the example ...
# ... now edit src/compress_command.sh to match the example ...
$ bashly generate
```

<!-- include: src/download_command.sh src/compress_command.sh -->

-----

## `bashly.yml`

````yaml
name: cli
help: Sample application demonstrating the use of variables
version: 0.1.0

# The `build_number` variable will be available globally
variables:
- name: build_number
  value: 1337

commands:
- name: download
  alias: d
  help: Download a profile

  args:
  - name: profile
    required: true
    help: Profile to download information from

  # These variables will be declared when the `download` command is executed.
  # Note the use of an array value.
  variables:
  - name: output_folder
    value: output
  - name: download_sources
    value:
    - youtube
    - instagram

- name: compress
  alias: c
  help: Compress data

  # These variables will be declared when the `compress` command is executed.
  # Note the use of an associative array value.
  variables:
  - name: zip_options
    value:
      pattern: "*.json"
      compression_level: fast
````

## `src/download_command.sh`

````bash
echo "build_number: $build_number"
echo "output_folder: $output_folder"
echo "download_sources:"
for value in "${download_sources[@]}"; do
  echo "- $value"
done
````

## `src/compress_command.sh`

````bash
echo "build_number: $build_number"
echo "zip_options:"
for key in "${!zip_options[@]}"; do
  echo "  $key: ${zip_options[$key]}"
done

````


## Output

### `$ ./cli download something`

````shell
build_number: 1337
output_folder: output
download_sources:
- youtube
- instagram


````

### `$ ./cli compress`

````shell
build_number: 1337
zip_options:
  compression_level: fast
  pattern: *.json


````



