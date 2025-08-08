echo "==[ Initialize Called ]=="

# Override the command line completely if the first argument is 'debug'
if [[ "${command_line_args[0]:-""}" = "debug" ]]; then
  command_line_args=("modified" "args" "--force")
fi
