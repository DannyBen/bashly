## INI functions [@bashly-upgrade ini]
## This file is a part of Bashly standard library
##
## Usage:
##
## - In your script, call `ini_load path/to/config.ini`.
## - A global associative array named `ini` will become available to you,
## - When updating any of the associative array's values, call
##   `ini_save path/to/config.ini` to save the data.
## - INI sections are optional.
##
## Get a value:
##
##   ${ini[section1.key1]}  # for keys under a [section]
##   ${ini[key1]}           # for keys not under a [section]
##   ${ini[key1]:-default}  # get a default value if the INI key is unset
##
## Update/create a value:
##
##   ini[section1.key1]="value"
##   ini_save path/to/config.ini
##
## Delete a value
##
##   unset ini[section1.key1]
##   ini_save path/to/config.ini
##
## Load an INI file and populate the associative array `ini`.
ini_load() {
  declare -gA ini

  local ini_file="$1"

  local section=""
  local key=""
  local value=""
  local section_regex="^\[(.+)\]"
  local key_regex="^([^ =]+) *= *(.*) *$"
  local comment_regex="^;"

  while IFS= read -r line; do
    if [[ $line =~ $comment_regex ]]; then
      continue
    elif [[ $line =~ $section_regex ]]; then
      section="${BASH_REMATCH[1]}."
    elif [[ $line =~ $key_regex ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      [[ $value == *\$* ]] && eval "value=\"$value\""
      ini["${section}${key}"]="$value"
    fi
  done <"$ini_file"
}

## Save the associative array `ini` back to a file
ini_save() {
  declare -gA ini

  local ini_file="$1"

  local current_section=""
  local has_free_keys=false

  rm -f "$ini_file"

  for key in $(ini_keys); do
    [[ $key == *.* ]] && continue
    has_free_keys=true
    value="${ini[$key]}"
    echo "$key = $value" >>"$ini_file"
  done

  [[ "${has_free_keys}" == "true" ]] && echo >>"$ini_file"

  for key in $(ini_keys); do
    [[ $key == *.* ]] || continue
    value="${ini[$key]}"
    IFS="." read -r section_name key_name <<<"$key"

    if [[ "$current_section" != "$section_name" ]]; then
      [[ $current_section ]] && echo >>"$ini_file"
      echo "[$section_name]" >>"$ini_file"
      current_section="$section_name"
    fi
    
    echo "$key_name = $value" >>"$ini_file"
  done
}

## Show all loaded key-value pairs
ini_show() {
  declare -gA ini

  for key in $(ini_keys); do
    echo "$key = ${ini[$key]}"
  done
}

## Get an array of all keys:
##
##   for key in $(ini_keys); do
##     echo "- $key = ${ini[$key]}";
##   done
##
ini_keys() {
  declare -gA ini

  local keys=("${!ini[@]}")
  for a in "${keys[@]}"; do echo "$a"; done | sort
}
