## Config (INI) functions [@bashly-upgrade config]
## This file is a part of Bashly standard library
##
## Usage:
## - In your script, call `config_load path/to/config.ini`.
## - A global associative array named `config` will become available to you,
##   and can be accessed like `${config[section1.key1]}`
##
config_load() {
  declare -gA config

  local config_file="$1"
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
      config["${section}${key}"]="$value"
    fi
  done < "$config_file"
}

## Show all loaded key-value pairs
config_show() {
  sorted_keys=($(echo "${!config[@]}" | tr ' ' '\n' | sort))

  for key in "${sorted_keys[@]}"; do 
    echo "$key = ${config[$key]}"
  done
}

## Save the array back to a file
config_save() {
  local filename="$1"
  local current_section=""

  rm -f "$filename"

  free_keys=($(echo "${!config[@]}" | tr ' ' '\n' | grep -v '\.' | sort))
  sectioned_keys=($(echo "${!config[@]}" | tr ' ' '\n' | grep '\.' | sort))

  for key in "${free_keys[@]}"; do
    value="${config[$key]}"
    echo "$key = $value" >> "$filename"
  done

  [[ $free_keys ]] && echo >> "$filename"

  for key in "${sectioned_keys[@]}"; do
    value="${config[$key]}"
    IFS="." read -r section_name key_name <<< "$key"

    if [[ "$current_section" != "$section_name" ]]; then
      [[ $current_section ]] && echo >> "$filename"
      echo "[$section_name]" >> "$filename"
      current_section="$section_name"
    fi
    
    echo "$key_name = $value" >> "$filename"
  done
}
