# Print an error string if docker is not running.
# The script will automatically exit if this function prints anything.
filter_docker_running() {
  docker info > /dev/null 2>&1 || echo "Docker must be running"
}
