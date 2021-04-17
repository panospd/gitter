#!/bin/bash

usage() {
  echo "Usage: ${0} -m 'COMMIT_MESSAGE' [-p] [REMOTE_NAME]";
  echo "  -m COMMIT_MESSAGE The commit message";
  echo "  -p If specified will push changes to respective remote";
  echo " REMOTE_NAME The remote to push changes to. If not specified, it defaults to 'origin'";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'
BRANCH=$(git branch --show-current);

while getopts "m:p" OPT;
do
  case ${OPT} in
    p) 
      PUSH=1
      shift $((OPTIND-1))
      ;;
    m) 
      MESSAGE="${OPTARG}" 
      shift $((OPTIND-1))
      shift $((OPTIND-1))
      ;;
    ?) usage ;;
  esac
done

if [[ -z "$MESSAGE" ]] || [[ "${MESSAGE}" = '' ]] || [[ "${MESSAGE}" = -* ]]
then 
  echo "You must provide a message"; 
  usage; 
fi

if [[ "${#}" -gt 1 ]]
then 
  echo "Only one optional argument expected, which is the remote name." >&2
  usage;
fi

if [[ "${#}" -eq 1 ]]
then
  REMOTE=$1;
fi

git add . &>/dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not stage files" >&2
  exit 1;
fi

echo "Staged all files.";

git commit -m "${MESSAGE}" > /dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not commit succesfully." >&2
  exit 1;
fi

echo "Commited changes."

if [[ "${PUSH}" -eq 1 ]]
then
  $(push -r ${REMOTE} ${BRANCH})
fi

exit 0;
