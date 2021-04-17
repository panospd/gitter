#!/bin/bash

usage() {
  echo "Usage: ${0} -m 'COMMIT_MESSAGE' [-p 'REMOTE_NAME']";
  echo "  -m COMMIT_MESSAGE The commit message";
  echo "  -p REMOTE_NAME If specified will push changes to respective remote";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'
BRANCH=$(git branch --show-current);

while getopts "m:p:" OPT;
do
  case ${OPT} in
    p) 
      REMOTE="${OPTARG}"
      ;;
    m) MESSAGE="${OPTARG}" ;;
    ?) usage ;;
  esac
done

if [[ -z "$MESSAGE" ]] || [[ "${MESSAGE}" = '' ]] || [[ "${MESSAGE}" = -* ]]
then 
  echo "You must provide a message"; 
  usage; 
fi

git add . &>/dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not stage files" >&2
  exit 1;
fi

echo "Staged all files.";

echo $REMOTE
echo $BRANCH

git commit -m "$MESSAGE" &>/dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not commit succesfully." >&2
  exit 1;
fi

echo "Commited changes."

if [[ ! -z "${PUSH}" ]]
then
  $(push -r ${REMOTE} ${BRANCH})
fi

exit 0;
