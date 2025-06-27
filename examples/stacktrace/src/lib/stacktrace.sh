## Stack trace functions [@bashly-upgrade stacktrace]
## This file is a part of Bashly standard library
##
## Usage:
## This function is designed to be called on error.
## 
## To enable this functionality, call `enable_stacktrace` in your
## `src/initialize.sh` (Run `bashly add hooks` to add this file).
##
enable_stacktrace() {
  trap 'stacktrace' ERR
  set -o errtrace
  set -o errexit
}

stacktrace() {
  local exit_status="$?"
  local i=0
  local caller_output line func file

  printf "%s:%s in \`%s\`: %s\n" "${BASH_SOURCE[0]}" "${BASH_LINENO[0]}" "${FUNCNAME[1]}" "$BASH_COMMAND"
  printf "\nStack trace:\n"
  while caller_output="$(caller $i)"; do
    read -r line func file <<<"$caller_output"
    printf "\tfrom %s:%s in \`%s\`\n" "$file" "$line" "$func"
    i=$((i + 1))
  done
  exit "$exit_status"
} >&2
