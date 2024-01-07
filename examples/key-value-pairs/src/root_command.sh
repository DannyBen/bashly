extract_params "${args[param]}"

echo "Positional Arguments:"
for key in "${!params[@]}"; do
  echo "$key => ${params[$key]}"
done

extract_params "${args[--option]}"

echo
echo "Options (--option):"
for key in "${!params[@]}"; do
  echo "$key => ${params[$key]}"
done
