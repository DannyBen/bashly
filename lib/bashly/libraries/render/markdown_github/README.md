# Render GitHub markdown

Render GitHub-compatible markdown documents for your script.

## Usage

```bash
# Generate all documents to the ./docs directory
$ bashly render :markdown_github docs

# Generate on change, and show one of the files
$ bashly render :markdown_github docs --watch --show index.md
```

The differences between this template and the `:markdown` template are:

- Links to sub-command files include the `.md` extension.
- The main file is named `README.md` instead of `index.md`.

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
