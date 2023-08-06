# Using the standard library (lib/config.sh) to store a value to the config
config_set "${args[key]}" "${args[value]}"
config_show
