#!/bin/bash

usage() {
  echo "Usage: ${0} -m 'COMMIT_MESSAGE' [-p] [REMOTE_NAME] [REMOTE_BRANCH_NAME]";
  echo "  -m COMMIT_MESSAGE The commit message";
  echo "  -p If specified will push changes to respective remote";
  echo " REMOTE_NAME The remote to push changes to. If not specified, it defaults to 'origin'";
  echo " REMOTE_BRANCH_NAME The remote to push changes to. If not specified, it defaults to currently checked out local branch's name";
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
      ;;
    m) 
      MESSAGE="${OPTARG}"
      ;;
    ?) usage ;;
  esac
done

shift $((OPTIND-1))

if [[ -z "$MESSAGE" ]] || [[ "${MESSAGE}" = '' ]] || [[ "${MESSAGE}" = -* ]]
then 
  echo "You must provide a message"; 
  usage; 
fi

if [[ "${#}" -gt 2 ]]
then 
  echo "Only two optional argument expected, remote_name and remote_branch_name." >&2
  usage;
fi

if [[ "$PUSH" -ne 1 ]] && [[ "${#}" -gt 0 ]]
then
  echo 'REMOTE_NAME and BRANCH_NAME detected, without -p option, which enables pushing changes to remote.'
  usage;
fi

if [[ "${#}" -gt 0 ]]
then
  REMOTE=$1;
  shift;
fi

if [[ "${#}" -gt 0 ]]
then
  BRANCH=$1;
  shift;
fi

git add . &>/dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not stage files" >&2
  exit 1;
fi

echo "Staged all files.";

git commit -m "${MESSAGE}" &> /dev/null

if [[ "${?}" -ne 0 ]]
then 
  echo "Could not commit succesfully." >&2
  exit 1;
fi

echo "Commited changes."

if [[ "${PUSH}" -eq 1 ]]
then
  push -r $REMOTE $BRANCH
fi

exit 0;
