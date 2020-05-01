file=${args[filename]}

if is existing "$file" ; then
  echo "File exists"

  if is writeable "$file" ; then
    echo "... and is writeable"
  else
    echo "... and is NOT writeable"
  fi

else
  echo "File does not exist"

fi
