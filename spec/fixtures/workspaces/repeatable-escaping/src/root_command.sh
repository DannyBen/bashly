inspect_args

if [[ -v args[term] ]]; then
  read -a terms <<< "${args['term']}"
  for t in "${terms[@]}"; do
    echo "[TERM] --> ${t}"
  done
fi

if [[ -v args[--search] ]]; then
  read -a terms <<< "${args['--search']}"
  for t in "${terms[@]}"; do
    echo "[--serach] --> ${t}"
  done
fi

echo