This is the source file for the `schemas/bashly.json` schema.

To regenerate the bashly.json schema, simply run:

```
$ run scheme generate
```

from the root directory of the project.

Alternatively, run the `yq` command directly:

```
$ yq -p yaml -o json support/schema/bashly.yml > schemas/bashly.json
```
