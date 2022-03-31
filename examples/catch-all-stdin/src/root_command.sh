inspect_args

# Read contents of the provided file(s)
content=""
for file in "${other_args[@]}"; do
  content+="$(cat "$file")"
  content+=$'\n'
done

# Read stdin if file(s) not provided as arguments
if [[ -z "$content" ]]; then
  content="$(cat -)"
fi

echo
echo "collected file contents:"
echo "$content"
echo
