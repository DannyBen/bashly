filename=${args[filename]:-}
variable=${args[variable]:-}
prefix=${args[--prefix]:-}

if [[ $variable ]]; then
  eval "$(yaml_load "$filename" "$prefix")"
  value=${!variable}

  if [[ $value ]]; then
    echo "$variable=$value"
  else
    echo "variable not found: $variable"
  fi

else
  yaml_load "$filename" "$prefix"

fi