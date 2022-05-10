# This is a YAML front matter describing the command
# It is imported to bashly.yml when running "bashly generate"

name: upload
alias: u
help: Upload a file
args:
- name: source
  required: true
  help: File to upload

flags:
  import: src/common_flags.yml

---
# Shell script starts here
inspect_args
