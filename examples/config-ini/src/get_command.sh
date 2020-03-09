# Using the standard library (lib/config.sh) to show a value from the config

key="${args[key]}"
if config_has_key "$key" ; then 
  config_get "$key"
else
  echo "No such key: $key"
fi

# Example of how to assign the config value to a variable:
# result=$(config_get "${args[key]}")
# echo $result

