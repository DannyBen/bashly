# Render mandoc

Render man pages for your script.

Note that this renderer will render specially formatted markdown documents and
will then use [pandoc](https://command-not-found.com/pandoc) to convert them.

## Usage

```bash
# Generate all man pages to the ./docs directory
$ bashly render :mandoc docs

# Generate on change, and show one of the files
$ bashly render :mandoc docs --watch --show cli-download.1
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

### See Also: `x_mandoc_see_also`

Adds additional pages to the `SEE ALSO` section, in addition to the
pages that are added automatically (like the parent command, and
sub commands).

This property should be an array of strings. You can optionally add
a section number in parentheses. If not provided, `(1)` will be used
as default.

#### Example

```yaml
x_mandoc_see_also:
  - docker
  - docker-compose.yml(5)
```
