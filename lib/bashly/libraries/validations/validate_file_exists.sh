## [@bashly-upgrade validations]
validate_file_exists() {
  if [[ ! -f "$1" ]]; then
    echo "must be an existing file"
  fi
}
