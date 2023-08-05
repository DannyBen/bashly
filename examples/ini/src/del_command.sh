# Using the standard library (lib/ini.sh) to delete a value from the config
ini_load config.ini

key="${args[key]}"
unset "ini[$key]"

ini_save saved.ini
cat saved.ini

