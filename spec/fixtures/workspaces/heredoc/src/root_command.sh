echo unindented

cat <<-FIRST_BLOCK
multiline
heredoc text
FIRST_BLOCK

echo also unindented

cat <<-SECOND_BLOCK
  1 indentation
    2 indentations
      3 indentations

      3 indentations with empty line above
SECOND_BLOCK

echo also unindented

echo "writing to file:"
cat <<EOF >output.txt
0 indentation
  1 indentation
  1 indentation
EOF

cat output.txt