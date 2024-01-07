## Convert an array of key=value pairs to an associative array.
## Calling this function will populate an associative array named `params`.
function extract_params {
  declare -gA params=()
  declare -a list=()
  local pattern="([^=]+)=(.+)"
  eval "list=($*)"
  
  for pair in "${list[@]}"; do
    if [[ $pair =~ $pattern ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      params["$key"]="$value"
    fi
  done
}