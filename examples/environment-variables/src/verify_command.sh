echo "# this file is located in 'src/verify_command.sh'"
echo "# code for 'cli verify' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

echo "environment:"
echo "- API_KEY=${API_KEY:-}"
echo "- ENVIRONMENT=${ENVIRONMENT:-}"
echo "- MY_SECRET=${MY_SECRET:-}"
