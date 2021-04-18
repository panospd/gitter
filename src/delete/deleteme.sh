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

if [[ "${?}" -ne 0 ]]
then
  echo "Could not checkout ${GOTOBRANCH}" >&2;
  exit 1;
fi

git branch -d $BRANCHTODELETE &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  echo "Force deletion of ${BRANCHTODELETE}?(y/n)";
  read FORCEDELETE;

  echo $FORCEDELETE;

  VALIDINPUT='false';
  while [[ $VALIDINPUT == 'false' ]] 
  do
    echo "Allowed input is y or n."
    read FORCEDELETE;

    if [[ ${FORCEDELETE} == "y" ]] || [[ ${FORCEDELETE} == "n" ]] 
    then
      VALIDINPUT='true';
    fi
  done  

  if [[ "${FORCEDELETE}" = "y" ]]
  then
    git branch -D $BRANCHTODELETE;
    echo "Successfully force-deleted ${BRANCHTODELETE}"
    exit 0;
  fi
fi

echo "Successfully deleted ${BRANCHTODELETE}"
exit 0;


