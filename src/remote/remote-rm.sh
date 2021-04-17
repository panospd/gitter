#!/bin/bash

usage() {
  echo "Usage: ${0} [REMOTE_NAME]";
  echo "  REMOTE_NAME The remote name. Defaults to origin";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'

if [[ $# -gt 1 ]]
then
  usage;
fi

if [[ $# -eq 1 ]]
then
  REMOTE=$1
fi

git remote rm $REMOTE;

if [[ "${?}" -ne 0 ]]
then 
  echo "Error: Could not remove remote ${REMOTE}"
  exit 2;
fi

echo "Successfully removed remote ${REMOTE}"
exit 0
