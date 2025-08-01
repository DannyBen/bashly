#!/usr/bin/env bash

funk() {
  cat <<EOF
start multiline heredoc test



end multiline heredoc test
EOF

  echo "unnecessary multiline test"



  echo "unnecessary multiline test complete"
        echo "rogue indentation"
}