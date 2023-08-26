# Render mandoc

Render man pages for your script.

Note that this renderer will render specially formatted markdown documents and
will then use [pandoc](https://command-not-found.com/pandoc) to convert them.

## Usage

```bash
# Generate all man pages to the ./docs directory
$ bashly render :mandoc docs
```

## Special template features

### Preview

Setting the environment variable `PREVIEW` to the full command you wish
to preview, will prompt the renderer to show the output using the `man`
command after rendering.

```bash
# Preview the page for the "cli download" command
$ PREVIEW="cli download" bashly render :mandoc docs

# .. and also watch for changes (after existing the man preview)
$ PREVIEW="cli download" bashly render :mandoc docs --watch
```

### Footer

You can add additional sections to any of the generated man pages, by
adding a property named `x_mandoc_footer` to any of your commands in
your `bashly.yml`.

This field should contain a markdown string, for example:

```yaml
x_mandoc_footer: |-
  # ISSUE TRACKER

  Report issues at <https://github.com/lanalang/smallville>
```

### Authors

You can specify an authors string that will be added to the man page,
by adding a property named `x_mandoc_authors` to any of your commands
in your `bashly.yml`.

For example:

```yaml
x_mandoc_authors: Lana Lang
```
