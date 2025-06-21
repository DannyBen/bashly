## Stack trace functions [@bashly-upgrade stacktrace]
## This file is a part of Bashly standard library
##
## Usage:
## This function is designed to be called on error.
## 
## To enable this functionality, add these lines to your `src/initialize.sh`
## file (Run `bashly add hooks` to add this file):
##
##   trap 'stacktrace' ERR
##   set -o errtrace
##
## Note that this functionality also requires `set -e`, which is enabled by
## default in bashly generated scripts.
##
stacktrace() {
  local i=0
  local caller_output line func file

  echo "${BASH_SOURCE[0]}:${BASH_LINENO[0]} in \`${FUNCNAME[1]}\`: $BASH_COMMAND"
  echo "Stack trace:"
  while caller_output="$(caller $i)"; do
    read -r line func file <<< "$caller_output"
    echo -e "\tfrom ${file}:${line} in \`$func\`"
    i=$((i + 1))
  done
  exit 1
} >&2
