# These filter functions can reside in any path under the `lib` directory.
# You can use a single file for all filter functions, or a separate file
# for each function.
# Note that the `${args[]}` array is available to you in your filter functions.

# Print an error string if docker is not running.
# The script will automatically exit if this function prints anything.
filter_docker_running() {
  docker info > /dev/null 2>&1 || echo "Docker must be running"
}

# This is just a sample filter designed to always fail
filter_redis_running() {
  echo "Redis must be running (always fails)"
}
