inspect_args

terms=''
if [[ -v args[term] ]]; then
  eval "terms=(${args[term]})"
  for t in "${terms[@]}"; do
    echo "[TERM] --> ${t}"
  done
fi

if [[ -v args[--search] ]]; then
  eval "terms=(${args[--search]})"
  for t in "${terms[@]}"; do
    echo "[--serach] --> ${t}"
  done
fi

echo