# Render mandoc

Render man pages for your script.

Note that this renderer will render specially formatted markdown documents and
will then use [pandoc](https://command-not-found.com/pandoc) to convert them.

Setting the environment variable `PREVIEW` to the full command you wish to
preview, will prompt the renderer to show the output using the `man` command
after rendering.

## Usage

```bash
# Generate all man pages to the ./docs directory
$ bashly render :mandoc docs

# .. and also preview the page for the "cli download" command
$ PREVIEW="cli download" bashly render :mandoc docs

# .. and also watch for changes
$ PREVIEW="cli download" bashly render :mandoc docs --watch
```

## Appending a footer

In case you wish to append additional sections to your generated man pages,
you can place a file named `_footer.md` in your target directory.
