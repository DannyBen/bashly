command="${args[command]}"
long_usage=yes

if [[ -z "$command" ]]; then
  # No command argument, show the global help
  help_function=cli_usage
else
  # Show the help for the requested command
  help_function="cli_${command}_usage"
fi

# Call the help function if it exists
if [[ $(type -t "$help_function") ]]; then
  "$help_function"
else
  echo "No help available for this command"
  exit 1
fi

