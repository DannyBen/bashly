## [@bashly-upgrade validations]
validate_integer() {
  if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "must be an integer"
  fi
}
