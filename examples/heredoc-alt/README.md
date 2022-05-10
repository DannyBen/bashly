# Heredoc Alternative Example

This example shows how you can use *Here document* (heredoc) constructs without
forcing the entire script to use tab indentation. 

Code in the `src/lib` directory is injected to your script as is, so in cases
where you must use heredocs, this is where you can.

This example was generated with:

```bash
$ bashly init
$ bashly add lib
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/root_command.sh to match the example ...
# ... now edit src/lib/heredocs.sh to match the example ...
$ bashly generate
```

<!-- include: src/root_command.sh src/lib/heredocs.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application showing the use of heredoc
version: 0.1.0
```

## `src/root_command.sh`

```bash
text="$(message1)"
echo "$text"
```

## `src/lib/heredocs.sh`

```bash
message1() {
  cat << EOF
this is a
  multiline
    heredoc text
EOF
}

```


## Generated script output

### `$ ./cli`

```shell
this is a
  multiline
    heredoc text


```



