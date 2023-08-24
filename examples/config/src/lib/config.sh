## Config (INI) functions [@bashly-upgrade config]
## This file is a part of Bashly standard library
##
## Usage:
##
## - Set the global variable CONFIG_FILE to the path of your INI file somewhere
##   in your script (for example, in src/initialize.sh).
## - Use any of the following functions to access and manipulate the values.
## - INI sections are optional (i.e., sectionless key=value pairs are allowed).
##

## Show all the key=value pairs from your config file
config_show() {
  config_load
  ini_show
}

## Get a single value from the config file:
##
##   config_get login.email
##
## Get the value or a default one if it is not set:
##
##   config_get login.user guest
##
## Assign the result to a variable:
##
##   theme="$(config_get interface.theme)"
##
config_get() {
  local key="$1"
  local default_value="$2"

  config_load
  echo "${ini["$key"]:-$default_value}"
}

## Create/update a key=value pair:
##
##   config_set cloud.provider aws
##
config_set() {
  local key="$1"
  shift
  local value="$*"

  config_load
  ini["$key"]="$value"
  config_save
}

## Delete a key=value pair:
##
##   config_del login.email
##
config_del() {
  local key="$1"

  config_load
  unset "ini[$key]"
  config_save
}

## Get an array of all keys:
##
##   for key in $(config_keys); do
##     echo "- $key = $(config_get "$key")";
##   done
##
config_keys() {
  config_load
  ini_keys
}

## Check if a key exists:
##
##   if config_has_key login.password; then
##     echo "key exists"
##   fi
##
config_has_key() {
  [[ $(config_get "$1") ]]
}

## Force-load from file
## This should normally not be called, unless you suspect that the INI file
## was modified by external means during the run of your script.
config_reload() {
  declare -g config_loaded=false
  config_load
}

## Load an INI file (unless loaded) and populate the associative array
## NOTE: Normally there is no need to call this function, it is called as needed
config_load() {
  [[ "$config_loaded" == "true" ]] && return

  declare -g CONFIG_FILE=${CONFIG_FILE:=config.ini}
  declare -g config_loaded=true
  [[ -f "$CONFIG_FILE" ]] || touch "$CONFIG_FILE"
  ini_load "$CONFIG_FILE"
}

## Save the associative array back to a file
## NOTE: Normally there is no need to call this function, it is called as needed
config_save() {
  ini_save "$CONFIG_FILE"
}
