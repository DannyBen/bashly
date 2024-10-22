echo "build_number: $build_number"
echo "output_folder: $output_folder"
echo "download_sources:"
for value in "${download_sources[@]}"; do
  echo "- $value"
done