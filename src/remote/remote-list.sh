#!/bin/bash

usage() {
  echo "Usage: ${0}";
  echo "Lists all remotes";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

git remote;