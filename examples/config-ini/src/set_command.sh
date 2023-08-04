# Using the standard library (lib/config.sh) to store a value to the config
config_load config.ini

key="${args[key]}"
value="${args[value]}"

config["$key"]="$value"
config_show
config_save saved.ini
