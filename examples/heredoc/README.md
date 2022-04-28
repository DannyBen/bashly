# Heredoc Example

This example shows how you can use *Here document* (heredoc) constructs.

By default, bashly indents all code using spaces. In order for heredoc to
properly work in bash, all leading spaces within the heredoc document must use
the tab character.

Setting the environment variable `BASHLY_TAB_INDENT` to any value will make
bashly replace the space indentation in the result, with tabs.

This example was generated with:

```bash
$ bashly init
# ... now edit src/bashly.yml to match the example ...
# ... now edit src/root_command.sh to match the example ...
$ BASHLY_TAB_INDENT=1 bashly generate
```

<!-- include: src/root_command.sh -->

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application showing the use of heredoc
version: 0.1.0
```

## `src/root_command.sh`

```bash
cat <<-EOF
multiline
heredoc text
EOF

# In case an inner indentation is needed, use a whitespace that is not a space
# and not a tab character. For example, Unicode U+3000 [　]
cat <<-EOF
this is
　an indented
　　multiline text
EOF


```


## Generated script output

### `$ ./cli`

```shell
multiline
heredoc text
this is
　an indented
　　multiline text


```



