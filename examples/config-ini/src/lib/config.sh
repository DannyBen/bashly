## Config (INI) functions [@bashly-upgrade config]
## This file is a part of Bashly standard library
##
## Usage:
##
## - In your script, call `config_load path/to/config.ini`.
## - A global associative array named `config` will become available to you,
## - When updating any of the associative array's values, call
##   `config_save path/to/config.ini` to save the data.
## - If a global variable named CONFIG_FILE exists, you can omit the filename
##   in `config_load` and `config_save`.
## - INI sections are optional.
##
## Get a value:
##
##   ${config[section1.key1]}  # for keys under a [section]
##   ${config[key1]}           # for keys not under a [section]
##   ${config[key1]:-default}  # get a default value if the config key is unset
##
## Update/create a value:
##
##   config[section1.key1]="value"
##   config_save path/to/config.ini
##
## Delete a value
##
##   unset config[section1.key1]
##   config_save path/to/config.ini

## Load a config file and populate the associative array `config`.
# shellcheck disable=SC2120
config_load() {
  declare -gA config

  local config_file="${1:-$CONFIG_FILE}"

  local section=""
  local key=""
  local value=""
  local section_regex="^\[(.+)\]"
  local key_regex="^([^ =]+) *= *(.*) *$"
  local comment_regex="^;"

  [[ -f "$config_file" ]] || touch "$config_file"

  while IFS= read -r line; do
    if [[ $line =~ $comment_regex ]]; then
      continue
    elif [[ $line =~ $section_regex ]]; then
      section="${BASH_REMATCH[1]}."
    elif [[ $line =~ $key_regex ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      config["${section}${key}"]="$value"
    fi
  done <"$config_file"
}

## Save the associative array `config` back to a file
# shellcheck disable=SC2120
config_save() {
  local config_file="${1:-$CONFIG_FILE}"

  local current_section=""
  local has_free_keys=false

  rm -f "$config_file"

  for key in $(config_keys); do
    [[ $key == *.* ]] && continue
    has_free_keys=true
    value="${config[$key]}"
    echo "$key = $value" >>"$config_file"
  done

  [[ "${has_free_keys}" == "true" ]] && echo >>"$config_file"

  for key in $(config_keys); do
    [[ $key == *.* ]] || continue
    value="${config[$key]}"
    IFS="." read -r section_name key_name <<<"$key"

    if [[ "$current_section" != "$section_name" ]]; then
      [[ $current_section ]] && echo >>"$config_file"
      echo "[$section_name]" >>"$config_file"
      current_section="$section_name"
    fi
    
    echo "$key_name = $value" >>"$config_file"
  done
}

## Show all loaded key-value pairs
config_show() {
  for key in $(config_keys); do 
    echo "$key = ${config[$key]}"
  done
}

## Get a newline delimited, sorted list of keys
config_keys() {
  local keys=("${!config[@]}")
  for a in "${keys[@]}"; do echo "$a"; done | sort
}
