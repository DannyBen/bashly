inspect_args

# Since cat knows how to handle '-' as a value, it will work with both a file
# path and '-' argument.
cat "${args[path]}"
