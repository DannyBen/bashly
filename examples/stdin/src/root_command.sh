inspect_args

# Since cat knows how to handle '-' as a value, it will work with both a file
# path and '-' argument.
cat "${args[path]}"

# To read the file yourself, use something like this
#
# if [[ "${args[path]}" == "-" ]]; then
#   file=$(</dev/stdin)
# else
#   file=$(<"${args[path]}")
# fi
