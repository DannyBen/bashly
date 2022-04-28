cat <<-EOF
multiline
heredoc text
EOF

# In case an inner indentation is needed, use a whitespace that is not a space
# and not a tab character. For example, Unicode U+3000 [　]
cat <<-EOF
this is
　an indented
　　multiline text
EOF

