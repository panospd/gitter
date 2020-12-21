#!/bin/bash

usage() {
  echo "Usage: deleteme [-g GOTOBRANCH]" >&2;
  echo "-g Optional. The branch to checkout, default is master" >&2;
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

GOTOBRANCH=master;

while getopts "g:" OPT
do
  case ${OPT} in
    g) GOTOBRANCH=${OPTARG} ;;
    *) usage ;;
  esac
done

BRANCHTODELETE=$(git branch --show-current);

if [[ $BRANCHTODELETE = $GOTOBRANCH ]]
then
  echo "Checked out branch cannot be deleted" >&2;
  exit 2;
fi

git checkout $GOTOBRANCH;
git branch -d $BRANCHTODELETE;

exit 0;


