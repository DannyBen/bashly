inspect_args

# Collect the catch_all
files=( ${other_args[*]} )

# Read contents of the provided file(s)
content=""
for file in "${files[@]}"; do
  content+="$(cat "$file")"
  content+=$'\n'
done

# Read stdin if file(s) not provided as arguments
if [[ -z "$content" ]]; then
  content="$(cat -)"
fi

echo "Collected file contents:"
echo "$content"


