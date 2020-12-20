#!/bin/bash

if [[ ! -d ".git" ]]
then
  echo "This is not a git repository";
  exit 10;
fi

exit 0;
