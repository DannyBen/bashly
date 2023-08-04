# Using the standard library (lib/config.sh) to show a value from the config
config_load config.ini

key="${args[key]}"
value=${config[$key]}

if [[ "$value" ]]; then
  echo "$key = $value"
else
  echo "No such key: $key"
fi
