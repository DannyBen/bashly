## [@bashly-upgrade validations]
validate_file_exists() {
  [[ -f "$1" ]] || echo "must be an existing file"
}
