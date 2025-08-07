echo "==[ Initialize Called ]=="

# Override the command line completely if the first argument is 'debug'
if [[ "${command_line[0]:-""}" = "debug" ]]; then
  command_line=("modified" "args" "--force")
fi
