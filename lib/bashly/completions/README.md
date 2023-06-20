# Completions for bashly executable

This directory contains support file for generating bash completions.

## For developers

From the root directory of the repository, run `run completions`. This will:

1. Read the `completely.yaml.gtx` template
2. Write the `completely.yaml` file
3. Generate the `bashly-completions.bash` file
4. Copy it to the completions directory with `sudo`

## For users

Install completions in one of two ways:

1. Run `bashly completions --install`. This will make a best effort to copy
   the completions script to your completions directory.
2. If the above fails, run `bashly completions > out.bash`, then copy the file
   manually to your completions directory (or simply get the
   `bashly-completions.bash` from this directory).
