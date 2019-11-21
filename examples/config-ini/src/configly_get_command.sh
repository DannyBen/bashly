# Using the standard library (lib/config.sh) to show a value from the config
config_get "${args[key]}"

# Example of how to assign the config value to a variable:"
# result=$(config_get "${args[key]}")
# echo $result

