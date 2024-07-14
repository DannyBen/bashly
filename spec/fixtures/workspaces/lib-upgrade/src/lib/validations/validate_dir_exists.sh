## [@bashly-upgrade validations]
validate_dir_exists() {
  [[ -d "$1" ]] || echo "must be an existing directory"
}
