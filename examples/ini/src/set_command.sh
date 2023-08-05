# Using the standard library (lib/ini.sh) to store a value to the config
ini_load config.ini

key="${args[key]}"
value="${args[value]}"

ini["$key"]="$value"
ini_save saved.ini
cat saved.ini
