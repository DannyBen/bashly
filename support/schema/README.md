This is the source file for `schemas/bashly.json` and `schemas/settings.json`
schemas.

To regenerate the, simply run:

```
$ run scheme generate
```

from the root directory of the project.

Alternatively, run the `yq` commands directly:

```
$ yq -p yaml -o json support/schema/bashly.yml > schemas/bashly.json
$ yq -p yaml -o json support/schema/settings.yml > schemas/settings.json
```
