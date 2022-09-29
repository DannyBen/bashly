if [[ -n "$API_KEY" ]]; then
  echo "PASS: API_KEY=$API_KEY"
else
  echo "FAIL: API_KEY is empty"
fi

if [[ -z "$NESTED_VAR" ]]; then
  echo "PASS: NESTED_VAR is empty"
else
  echo "FAIL: NESTED_VAR=$NESTED_VAR"
fi


