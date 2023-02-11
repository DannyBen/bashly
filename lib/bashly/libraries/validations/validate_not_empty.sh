## [@bashly-upgrade validations]
validate_not_empty() {
  [[ -z "$1" ]] && echo "must not be empty"
}
