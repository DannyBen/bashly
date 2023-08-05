# Using the standard library (lib/ini.sh) to show a value from the config
ini_load config.ini

key="${args[key]}"
value=${ini[$key]}

if [[ "$value" ]]; then
  echo "$key = $value"
else
  echo "No such key: $key"
fi
