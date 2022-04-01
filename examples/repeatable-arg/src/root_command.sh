# Convert the space delimited string to an array
files=''
eval "files=(${args[file]})"

echo
echo "files:"
for i in "${files[@]}"; do
  echo "  path: $i:"
  content="$(cat "$i")"
  echo "  content: ${content}"
  echo "  upcase: ${content^^}"
done

echo
inspect_args
