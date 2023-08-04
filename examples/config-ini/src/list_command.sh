# Using the standard library (lib/config.sh) to show the entire config file
config_load config.ini
config_show

# Or to iterate through keys manually
for key in "${!config[@]}"; do 
  echo "$key = ${config[$key]}"
done