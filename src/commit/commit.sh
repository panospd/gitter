#!/bin/bash

usage() {
  echo "Usage: ${0} -m MESSAGE [-p]";
  echo "  -m MeSSAGE The commit message";
  echo "  -p If specified will push changes to remote branch";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'
BRANCH=$(git branch --show-current);

while getopts "m:pr:" OPT;
do
  case ${OPT} in
    p) PUSH="git push" ;;
    m) MESSAGE="${OPTARG}" ;;
    r) REMOTE="${OPTARG}" ;;
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

git commit -m "$MESSAGE" &>/dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could commit succesfully." >&2
  exit 1;
fi

echo "Commited changes."

if [[ ! -z "${PUSH}" ]]
then
  push ${REMOTE} ${BRANCH}
fi

exit 0;
