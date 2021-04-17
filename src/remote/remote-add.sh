#!/bin/bash

usage() {
  echo "Usage: ${0} [-r REMOTE_NAME] REMOTE_URL";
  echo "  -R The remote name. Defaults to origin";
  echo " REMOTE_URL The remote url to be used in order to add it.";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'

while getopts "r:" OPT;
do
  case ${OPT} in
    r) 
      REMOTE="${OPTARG}" 
      shift $((OPTIND-1))
      shift $((OPTIND-1)) 
      ;;
    ?) usage ;;
  esac
done


if [[ "${#}" -ne 1 ]]
then
  echo "${0} expects only one argument, which is the url of the remote to be added";
  usage;
fi

echo $REMOTE
echo $1

git remote add $REMOTE $1;

if [[ "${?}" -ne 0 ]]
then 
  echo "Error: Could not add remote ${REMOTE}, url: $1"
  exit 2;
fi

echo "Successfully added remote ${REMOTE}"
exit 0
