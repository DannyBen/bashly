Bashly - Bash CLI Generator
==================================================

Create beautiful bash scripts from simple YAML configuration.

[![Gem Version](https://badge.fury.io/rb/bashly.svg)](https://badge.fury.io/rb/bashly)
[![Build Status](https://travis-ci.com/DannyBen/bashly.svg?branch=master)](https://travis-ci.com/DannyBen/bashly)
[![Maintainability](https://api.codeclimate.com/v1/badges/8cf89047e50ca601e431/maintainability)](https://codeclimate.com/github/DannyBen/bashly/maintainability)

---

![demo](demo/cast.svg)

---

Installation
--------------------------------------------------

    $ gem install bashly


Usage
--------------------------------------------------

In an empty directory, create a sample configuration file by running

    $ bashly init
    # or, to generate a simpler configuration:
    $ bashly init --minimal

This will create a sample `src/bashly.yml` file.
You can edit this file to specify which arguments, flags and subcommands you
need in your bash script.

Then, generate an initial bash script and function placeholder scripts by
running

    $ bashly generate

This will:

1. Create the bash executable script.
2. Create files for you to edit in the `src` folder.

Finally, edit the files in the `src` folder. Each of your script's commands
get their own file. Once you edit, run `bashly generate` again to merge the
content from your functions back into the script.


Contributing / Support
--------------------------------------------------

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

[issues]: https://github.com/DannyBen/bashly/issues

