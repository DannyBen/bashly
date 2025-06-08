# We must record the `args` array to our local variables, due to the fact
# that calling `run` will reset it.
build=${args['--build']}
test=${args['--test']}

# Call other commands in the same way they would be called in the CLI.
[[ $build ]] && run build production
[[ $test ]] && run test --full

# Perform the purpose of this command.
echo "DEPLOY complete"
inspect_args

