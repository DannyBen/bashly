# Render mandoc

Render man pages for your script.

Note that this renderer will render specially formatted markdown documents and
will then use [pandoc](https://command-not-found.com/pandoc) to convert them.

## Usage

```bash
# Generate all man pages to the ./docs directory
$ bashly render :mandoc docs
```

## Viewing the output

Setting the environment variable `PREVIEW` to the full command you wish
to preview, will prompt the renderer to show the output using the `man`
command after rendering.

```bash
# Preview the page for the "cli download" command
$ PREVIEW="cli download" bashly render :mandoc docs

# .. and also watch for changes (after existing the man preview)
$ PREVIEW="cli download" bashly render :mandoc docs --watch
```

In addition, you can use one of the following commands:

```bash
# View the man page interactively
$ man docs/cli-download.1

# Print the man page to stdout
$ man docs/cli-download.1 | col -bx
```

## Supported custom definitions

Add these definitions to your `bashly.yml` to render them in your
markdown:

### Footer: `x_mandoc_footer`

Add additional sections to your man pages. This field is expected
to be in markdown format.

#### Example

```yaml
x_mandoc_footer: |-
  # ISSUE TRACKER

  Report issues at <https://github.com/lanalang/smallville>
```

### Authors: `x_mandoc_authors`

Add an authors string to your man pages.

#### Example

```yaml
x_mandoc_authors: Lana Lang
```
