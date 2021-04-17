#!/bin/bash

isgit;
git checkout -- .
git clean -f

if [[ "${?}" -ne 0 ]]
then
  echo 'Error: Could not undo changes'
  exit 2;
fi

echo 'Successfully undone changes'
exit 0;