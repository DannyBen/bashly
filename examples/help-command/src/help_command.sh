command="${args[command]}"
long_usage=yes

# If we have reached this point, we know that the help subject is valid, so 
# just call the relevant help function.
if [[ -z "$command" ]]; then
  cli_usage
else
  "cli_${command}_usage"
fi
