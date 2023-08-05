# Using the standard library (lib/config.sh) to show a value from the config

key="${args[key]}"
if config_has_key "$key"; then
  config_get "$key"
else
  echo "No such key: $key"
fi

# Or, assign a default value if value not found
config_get "$key" "the default value"

# Or, assign the result to a variable
result=$(config_get "$key")
echo "$result"

