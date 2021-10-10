# this syntax (`[[ -v`) cannot be parsed by bash 3
if [[ -v missingno ]]; then
  echo the variable was not defined
fi
