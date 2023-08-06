# Using the standard library (lib/config.sh) to delete a value from the config

key="${args[key]}"
config_del "$key"
config_show
