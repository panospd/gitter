#!/bin/bash

usage() {
  echo "Usage: deleteme [-g GOTOBRANCH] [-f] [BRANCHTODELETE]" >&2;
  echo "-f Optional. Force delete flag" >&2;
  echo "-g Optional. The branch to checkout, default is master" >&2;
  echo "BRANCHTODELETE Optional. The branch to delete, default to currently checked out" >&2;
  exit 1;
}

forceDeleteInputValidation() {
  if [[ ${FORCEDELETE} == "y" ]] || [[ ${FORCEDELETE} == "n" ]] 
  then
    VALIDINPUT='true';
  else
    VALIDINPUT='false';
  fi
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

GOTOBRANCH=master;

while getopts "g:f" OPT
do
  case ${OPT} in
    g) GOTOBRANCH=${OPTARG} ;;
    f) FORCEDELETE=1 ;;
    ?) usage ;;
  esac
done

shift $((OPTIND-1))

if [[ "${#}" -gt 1 ]]
then
  usage;
fi

if [[ "${#}" -gt 0 ]]
then
  BRANCHTODELETE=$1;
else
  BRANCHTODELETE=$(git branch --show-current);
fi

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

if [[ "${?}" -eq 0 ]]
then
  echo "Successfully deleted ${BRANCHTODELETE}"
  exit 0;
fi

if [[ $FORCEDELETE -eq 1 ]] 
then
  git branch -D $BRANCHTODELETE;
  echo "Successfully force-deleted ${BRANCHTODELETE} branch"
  exit 0;
fi

echo "Force deletion of ${BRANCHTODELETE}?(y/n)";
read FORCEDELETE;

VALIDINPUT=''
forceDeleteInputValidation;
while [[ $VALIDINPUT == 'false' ]] 
do
  echo "Allowed input is y or n."
  read FORCEDELETE;

  forceDeleteInputValidation;
done  

if [[ "${FORCEDELETE}" = "y" ]]
then
  git branch -D $BRANCHTODELETE;
  echo "Successfully force-deleted ${BRANCHTODELETE} branch"
  exit 0;
else
  echo "${BRANCHTODELETE} branch was NOT deleted."
  exit 0;
fi


