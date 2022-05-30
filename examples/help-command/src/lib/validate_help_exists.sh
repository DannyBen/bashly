# This function will be called automatically with the argument under validation
# as provided by the user.
# It will then check that the internal bashly function responsible for showing
# help exists, and echo an error if it does not.
validate_help_exists() {
  command="$1"
  
  if [[ -z "$command" ]]; then
    # The user called `cli help` - so the help function is the root cli_usage
    # function (replace 'cli' with the name of your script).
    function_name="cli_usage"
  
  else
    # The user called `cli help COMMAND` - so we check that the command is valid
    # by ensuring we have a help function for it.
    function_name="cli_${command}_usage"
  fi
  
  [[ $(type -t "$function_name") ]] || echo "no help for this command"
}