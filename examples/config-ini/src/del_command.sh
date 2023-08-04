# Using the standard library (lib/config.sh) to delete a value from the config
config_load config.ini

key="${args[key]}"
unset "config[$key]"

config_save saved.ini
cat saved.ini

