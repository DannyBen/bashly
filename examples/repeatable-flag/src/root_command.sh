# Convert the space delimited string to an array
eval "data=(${args[--data]})"

echo "Data elements:"
for i in "${data[@]}"; do
  echo "$i"
done

# The --verbose arg will contain the number of times it was used by the user
verbose=${args[--verbose]}
echo ""
echo "Verbosity level: $verbose"
echo ""

inspect_args
