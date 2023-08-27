# Render markdown

Render markdown documents for your script.

## Usage

```bash
# Generate all documents to the ./docs directory
$ bashly render :markdown docs

# Generate on change, and show one of the files
$ bashly render :markdown docs --watch --show index.md
```

## Supported custom definitions

Add these definitions to your `bashly.yml` to render them in your
markdown:

### Footer: `x_markdown_footer`

Add additional sections to your man pages. This field is expected
to be in markdown format.

#### Example

```yaml
x_markdown_footer: |-
  # ISSUE TRACKER

  Report issues at <https://github.com/lanalang/smallville>
```

## Markdown server

In order to view your markdown files in a browser, you can use the
[Madness markdown server](https://madness.dannyb.co/):

```bash
$ gem install madness
$ madness server docs
```
