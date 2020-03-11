# Using the standard library (lib/config.sh) to show the entire config file
config_show

# Or to iterate through keys
for key in $(config_keys) ; do
  echo "$key === $(config_get "$key")"
done
