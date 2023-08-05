# Using the standard library (lib/ini.sh) to show the entire config file
ini_load config.ini
ini_show

## Or iterate through keys manually
# for key in $(ini_keys); do 
#   echo "$key = ${ini[$key]}"
# done