echo "build_number: $build_number"
echo "zip_options:"
for key in "${!zip_options[@]}"; do
  echo "  $key: ${zip_options[$key]}"
done
echo "environments:"
for value in "${environments[@]}"; do
  echo "- $value"
done