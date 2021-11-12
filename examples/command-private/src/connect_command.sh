# Execute a subsequent (private) command based on the PROTOCOL argument
protocol=${args[protocol]}
cmd="./cli connect-$protocol"
echo "=== Calling $cmd"
$cmd