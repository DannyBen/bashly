## [@bashly-upgrade validations]
validate_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] || echo "must be an integer"
}